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

        neutralMessage = "You’re now logged out._PLC"
    }

    func showSignUpUser() {
        isSignUpPresented = true
    }

    func showLogInUser() {
        isLogInPresented = true
    }

    func showSuccessLoginMessage() {
        successMessage = "You’re in. Enjoy the festival!_PLC"
    }
}
