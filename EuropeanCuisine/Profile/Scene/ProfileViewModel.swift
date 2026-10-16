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
    }

    func showSignUpUser() {
        isSignUpPresented = true
    }

    func showLogInUser() {
        isLogInPresented = true
    }
}
