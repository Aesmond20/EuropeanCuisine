//
//  ProfileViewModel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class ProfileViewModel {
    private let store: UserStore

    var isSignUpPresented: Bool
    var isLogInPresented: Bool

    var neutralMessage: String?
    var successMessage: String?

    init(store: UserStore) {
        self.store = store
        self.isSignUpPresented = false
        self.isLogInPresented = false
    }

    var user: User? {
        store.user
    }

    var hasUser: Bool {
        user != nil
    }

    func logOutUser() {
        store.removeToken()

        showLogOutMessage()
    }

    func showSignUpUser() {
        isSignUpPresented = true
    }

    func showLogInUser() {
        isLogInPresented = true
    }

    func showSuccessLogInMessage() {
        Task {
            try? await Task.sleep(for: .seconds(0.4))

            successMessage = String(localized: .profileMessageNowLoggedIn)
        }
    }

    func showLogOutMessage() {
        Task {
            try? await Task.sleep(for: .seconds(0.3))

            neutralMessage = String(localized: .profileMessageNowLoggedOut)
        }
    }
}
