//
//  OnboardingSignUpViewModel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 02/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class OnboardingSignUpViewModel {
    var step: Step
    var email: String
    var password: String
    var confirmPassword: String
    var name: String

    var isGoingForward = true

    private let store: UserStore
    private var close: () -> Void
    private let onOpenLogIn: () -> Void
    private(set) var isFullscreen: Bool

    private let authClient: AuthAPIClient

    enum Step: CaseIterable {
        case email
        case password
        case name

        var current: UInt8 {
            switch self {
            case .email:
                1
            case .password:
                2
            case .name:
                3
            }
        }

        var total: UInt8 {
            UInt8(Step.allCases.count)
        }

        var previous: Step? {
            switch self {
            case .email:
                nil
            case .password:
                .email
            case .name:
                .password
            }
        }

        var next: Step? {
            switch self {
            case .email:
                .password
            case .password:
                .name
            case .name:
                nil
            }
        }

        var isFirst: Bool {
            self == .email
        }
    }

    init(isFullscreen: Bool?,
         store: UserStore,
         close: @escaping () -> Void,
         onOpenLogIn: @escaping () -> Void) {
        self.step = .email
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.name = ""
        self.authClient = .init()
        self.store = store
        self.close = close
        self.onOpenLogIn = onOpenLogIn
        self.isFullscreen = (isFullscreen == true)
    }

    // MARK: - Public computed properties

    var isFirstStep: Bool {
        step.isFirst
    }

    var currentStep: UInt8 {
        step.current
    }

    var totalStep: UInt8 {
        step.total
    }

    var actionLabel: String {
        switch step {
        case .email:
            String(localized: .globalButtonContinueLabel)
        case .password:
            String(localized: .globalButtonContinueLabel)
        case .name:
            String(localized: .globalButtonSignUpLabel)
        }
    }

    var actionKind: OrangeadeProminentButtonStyle.Kind {
        switch step {
        case .email:
            .tertiary
        case .password:
            .tertiary
        case .name:
            .primary
        }
    }

    var topTrailingSplashKind: TopTrailingSplash.Kind {
        switch step {
        case .email:
            .tertiary
        case .password:
            .secondary
        case .name:
            .quaternary
        }
    }

    var isActionDisabled: Bool {
        switch step {
        case .email:
            !isEmailValid
        case .password:
            !isPasswordValid
        case .name:
            !isNameValid
        }
    }

    var emailErrorMessages: [String] {
        var messages: [String] = []

        if email.isEmpty {
            return []
        }

        if !isEmailValid {
            messages.append(String(localized: .onboardingFieldEmailErrorMessageIsNotValid))
        }

        return messages
    }

    var nameErrorMessages: [String] {
        var messages: [String] = []

        if name.isEmpty {
            return []
        }

        if isNameTooShort {
            messages
                .append(String(localized: .onboardingFieldNameErrorMessageTooShort(min: Constraints
                        .User.Name.length.lowerBound)))
        }

        if isNameTooLong {
            messages
                .append(String(localized: .onboardingFieldNameErrorMessageTooLong(max: Constraints
                        .User.Name.length.upperBound)))
        }

        return messages
    }

    var passwordErrorMessages: [String] {
        var messages: [String] = []

        if isPasswordTooLong {
            messages
                .append(String(localized: .onboardingFieldPasswordErrorMessageTooLong(max: Constraints
                        .User.Password.length.upperBound)))
        }

        return messages
    }

    var passwordHasUppercaseLetter: Bool {
        Constraints.hasUppercaseLetter(password)
    }

    var passwordHasLowercaseLetter: Bool {
        Constraints.hasLowercaseLetter(password)
    }

    var passwordHasAtLeastOneNumber: Bool {
        Constraints.hasAtLeastOneNumber(password)
    }

    var passwordHasAtLeastXcharacters: Bool {
        Constraints.hasAtLeastXcharacters(password,
                                          minLength: Constraints.User.Password.length.lowerBound)
    }

    var passwordMatch: Bool {
        password.isNotEmpty && password == confirmPassword
    }

    // MARK: - Public methods

    func goToPrevious() {
        isGoingForward = false

        guard let previous = step.previous else {
            close()
            return
        }

        advance(to: previous)
    }

    func goToNext() {
        isGoingForward = true

        guard let next = step.next else {
            registerAndLogInUser()
            return
        }

        advance(to: next)
    }

    func openLogIn() {
        close()
        onOpenLogIn()
    }

    // MARK: - Private properties

    private var isEmailValid: Bool {
        Constraints.isEmail(email)
    }

    private var isNameTooShort: Bool {
        guard name.trimmed.count < Constraints.User.Name.length.lowerBound else {
            return false
        }

        return true
    }

    private var isNameTooLong: Bool {
        guard name.trimmed.count > Constraints.User.Name.length.upperBound else {
            return false
        }

        return true
    }

    private var isNameValid: Bool {
        !isNameTooShort && !isNameTooLong
    }

    private var isPasswordTooShort: Bool {
        guard password.count < Constraints.User.Password.length.lowerBound else {
            return false
        }

        return true
    }

    private var isPasswordTooLong: Bool {
        guard password.count > Constraints.User.Password.length.upperBound else {
            return false
        }

        return true
    }

    private var isPasswordValid: Bool {
        !isPasswordTooShort
            && !isPasswordTooLong
            && passwordHasUppercaseLetter
            && passwordHasLowercaseLetter
            && passwordHasAtLeastOneNumber
            && passwordHasAtLeastXcharacters
            && passwordMatch
    }

    // MARK: - Private methods

    private func advance(to newStep: Step) {
        Task { @MainActor in
            // permet de corriger un bug de transition des pages
            // lors du changement de sens.
            // Ex : vers la droite puis vers la gauche
            await Task.yield()
            withAnimation(.smooth) {
                step = newStep
            }
        }
    }

    private func registerUser() async throws -> SignUpResponse {
        let requestData: SignUpRequest = .init(name: name.trimmed,
                                               email: email.trimmed,
                                               password: password)

        return try await authClient.signUp(input: requestData)
    }

    private func logInUser() async throws -> TokenResponse {
        let requestData: LogInRequest = .init(email: email.trimmed,
                                              password: password)

        return try await authClient.logIn(input: requestData)
    }

    private func registerAndLogInUser() {
        Task {
            do {
                _ = try await registerUser()
                let tokenResponse = try await logInUser()

                store.addToken(tokenResponse.token)

                close()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
