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

    var errorMessage: String?

    private let close: () -> Void
    private let store: UserStore
    private let onOpenSignUp: () -> Void
    private let authClient: AuthAPIClient
    private(set) var isFullscreen: Bool

    init(isFullscreen: Bool?,
         store: UserStore,
         close: @escaping () -> Void,
         onOpenSignUp: @escaping () -> Void) {
        self.email = ""
        self.password = ""
        self.errorMessage = nil
        self.store = store
        self.close = close
        self.onOpenSignUp = onOpenSignUp
        self.authClient = .init()
        self.isFullscreen = (isFullscreen == true)
    }

    var isValid: Bool {
        isEmailValid && isPasswordValid
    }

    func goBack() {
        close()
    }

    func openSignUp() {
        close()
        onOpenSignUp()
    }

    func logInUser() {
        Task {
            do {
                let requestData: LogInRequest = .init(email: email,
                                                      password: password)

                let tokenResponse = try await authClient.logIn(input: requestData)

                store.addToken(tokenResponse.token)

                close()
            } catch let AuthAPIClientError.badStatus(code, reason) {
                errorMessage = "Invalid credentials"
                print("E\(code): \(reason)")
            } catch {
                errorMessage = error.localizedDescription
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
