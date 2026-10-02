//
//  OnboardingLogInScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingLogInScene: View {
    @State private var email: String = ""
    @State private var password: String = ""

    @FocusState private var focusedField: Field?

    enum Field {
        case email
        case password
    }

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                VStack(spacing: Styles.titleFormSpacing) {
                    OnboardingHeader(title: "Log in",
                                     subtitle: "Welcome back! Log in to continue your food journey.")

                    VStack(spacing: Styles.formVerticalSpacing) {
                        InputLabelWithContent(label: "Email") {
                            TextInput("sasha@hamel.me",
                                      text: $email,
                                      icon: AppImage.Icon.fieldEmail.image,
                                      isFocused: focusedField == .email)
                                .focused($focusedField, equals: .email)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                        }

                        InputLabelWithContent(label: "Password") {
                            VStack(alignment: .trailing,
                                   spacing: Styles.passwordForgotSpacing) {
                                SecureInput("Password",
                                            text: $password,
                                            icon: AppImage.Icon.fieldPassword.image,
                                            isFocused: focusedField == .password)
                                    .focused($focusedField, equals: .password)
                                    .autocorrectionDisabled(true)
                                    .textInputAutocapitalization(.never)
                                    .textContentType(.password)

                                Button("Forgot your password?", action: {})
                                    .font(Styles.forgotFont)
                                    .tint(Styles.accentColor)
                            }
                        }
                    }
                }
                .padding(.vertical, Styles.mainVerticalPadding)

                Spacer()
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
        .safeAreaInset(edge: .top) {
            HStack(spacing: .zero) {
                Button("", action: {})
                    .buttonStyle(.orangeadeIconProminent(kind: .onboarding,
                                                         icon: AppImage.Icon.back.image))
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .center,
                   spacing: Styles.actionsVerticalSpacing) {
                Button(.globalButtonLogInLabel, action: {})
                    .buttonStyle(.orangeadeProminent(kind: .primary,
                                                     isFullWidth: true))

                OnboardingMessageWithAction(message: "Don't have an account?",
                                            actionMessage: String(localized: .globalButtonSignUpLabel),
                                            action: {})
            }
            .padding(.horizontal)
        }
        .background {
            Styles.background
                .ignoresSafeArea(.all)
        }
    }
}

fileprivate enum Styles {
    static let accentColor = AppColor.accentPrimary
    static let background = AppColor.Scene.background

    static let mainVerticalPadding = AppToken.Primitive.padding8

    static let actionsVerticalSpacing = AppToken.Primitive.spacing3

    static let titleFormSpacing = AppToken.Primitive.spacing8
    static let formVerticalSpacing = AppToken.Primitive.spacing4

    static let passwordForgotSpacing = AppToken.Primitive.spacing2
    static let forgotFont: Font = .system(size: 15,
                                          weight: .medium)
}

#Preview {
    OnboardingLogInScene()
}
