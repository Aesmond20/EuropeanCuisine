//
//  OnboardingStartViewModel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class OnboardingStartViewModel {
    var isSignUpPresented: Bool
    var isLogInPresented: Bool
    private(set) var store: UserStore

    private let close: () -> Void

    init(store: UserStore,
         close: @escaping () -> Void) {
        self.isSignUpPresented = false
        self.isLogInPresented = false
        self.store = store
        self.close = close
    }

    func goBack() {
        close()
    }

    func showSignUp() {
        isSignUpPresented = true
    }

    func showLogIn() {
        isLogInPresented = true
    }
}
