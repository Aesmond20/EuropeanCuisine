//
//  OnboardingLogInScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingLogInScene: View {
    @State private var vm: OnboardingLogInViewModel

    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) private var dismiss

    enum Field {
        case email
        case password
    }

    init(onOpenSignUp: @escaping () -> Void,
         onSuccess: @escaping (String) -> Void) {
        self._vm = State(initialValue: .init(onOpenSignUp: onOpenSignUp,
                                             onSuccess: onSuccess))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                VStack(spacing: Styles.titleFormSpacing) {
                    formHeaderView

                    formView
                }
                .padding(.top, Styles.mainTopPadding)
                .padding(.bottom, Styles.mainBottomPadding)

                Spacer()
            }
            .padding(.horizontal)
        }
        .scrollBounceBehavior(.basedOnSize)
        .onboardingHeader(topTrailingSplash: .init(version: .two, kind: .primary)) {
            headerView
        }
        .onboardingFooter {
            footerView
        }
        .background {
            Styles.background
                .ignoresSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.addClose { dismiss() }
        }
    }

    private func close() {
        dismiss()
    }

    private var headerView: some View {
        HStack(spacing: .zero) {
            Button("", action: close)
                .buttonStyle(.orangeadeIconProminent(kind: .onboarding,
                                                     icon: AppImage.Icon.back.image))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var formHeaderView: some View {
        OnboardingFormHeader(title: .onboardingLogInViewTitle,
                             subtitle: .onboardingLogInViewSubtitle)
    }

    private var formView: some View {
        VStack(spacing: Styles.formVerticalSpacing) {
            emailView

            passwordView
        }
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            case .password:
                focusedField = nil
            case nil:
                break
            }
        }
    }

    private var emailView: some View {
        InputLabelWithContent(label: .onboardingFieldEmailLabel) {
            TextInput(.onboardingFieldEmailPlaceholder,
                      text: $vm.email,
                      icon: AppImage.Icon.fieldEmail.image,
                      isFocused: focusedField == .email)
                .focused($focusedField, equals: .email)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .submitLabel(.next)
        }
    }

    private var passwordView: some View {
        InputLabelWithContent(label: .onboardingFieldPasswordLabel) {
            VStack(alignment: .trailing,
                   spacing: Styles.passwordForgotSpacing) {
                SecureInput(.onboardingFieldPasswordPlaceholder,
                            text: $vm.password,
                            icon: AppImage.Icon.fieldPassword.image,
                            isFocused: focusedField == .password)
                    .focused($focusedField, equals: .password)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
                    .submitLabel(.done)

                Button(.onboardingFieldPasswordForgotPassword, action: {})
                    .font(Styles.forgotFont)
                    .tint(Styles.accentColor)
            }
        }
    }

    private var footerView: some View {
        VStack(alignment: .center,
               spacing: Styles.actionsVerticalSpacing) {
            Button(.globalButtonLogInLabel, action: vm.logInUser)
                .buttonStyle(.orangeadeProminent(kind: .primary,
                                                 isFullWidth: true))
                .disabled(!vm.isValid)

            OnboardingMessageWithAction(message: .onboardingMessageQuestionHasNotAccount,
                                        actionMessage: .globalButtonSignUpLabel,
                                        action: vm.openSignUp)
        }
        .padding(.horizontal)
    }
}

fileprivate enum Styles {
    static let accentColor = AppColor.accentPrimary
    static let background = AppColor.Scene.background

    static let mainTopPadding = AppToken.Primitive.padding2
    static let mainBottomPadding = AppToken.Primitive.padding8

    static let actionsVerticalSpacing = AppToken.Primitive.spacing3

    static let titleFormSpacing = AppToken.Primitive.spacing8
    static let formVerticalSpacing = AppToken.Primitive.spacing4

    static let passwordForgotSpacing = AppToken.Primitive.spacing2
    static let forgotFont: Font = .system(size: 15,
                                          weight: .medium)
}

#Preview {
    OnboardingLogInScene(onOpenSignUp: {},
                         onSuccess: { _ in })
}
