//
//  OnboardingLogInViewModel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class OnboardingLogInViewModel {
    var email: String
    var password: String

    private var close: (() -> Void)?

    private let onOpenSignUp: () -> Void
    private let onSuccess: (String) -> Void
    private let authClient: AuthAPIClient

    init(onOpenSignUp: @escaping () -> Void,
         onSuccess: @escaping (String) -> Void) {
        self.email = ""
        self.password = ""
        self.onOpenSignUp = onOpenSignUp
        self.onSuccess = onSuccess
        self.authClient = .init()
    }

    var isValid: Bool {
        isEmailValid && isPasswordValid
    }

    func addClose(_ action: @escaping () -> Void) {
        close = action
    }

    func openSignUp() {
        close?()
        onOpenSignUp()
    }

    func logInUser() {
        Task {
            do {
                let requestData: LogInRequest = .init(email: email,
                                                      password: password)

                let token = try await authClient.logIn(input: requestData)

                close?()
                onSuccess(token.token)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    private var isEmailValid: Bool {
        Constraints.isEmail(email)
    }

    private var isPasswordValid: Bool {
        password.isNotEmpty
    }
}
