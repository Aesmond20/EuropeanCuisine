//
//  OnboardingLogInScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import PopupView
import SwiftUI

struct OnboardingLogInScene: View {
    @Environment(UserStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    private let onOpenSignUp: () -> Void
    private let isFullscreen: Bool?

    init(isFullscreen: Bool? = nil,
         onOpenSignUp: @escaping () -> Void) {
        self.isFullscreen = isFullscreen
        self.onOpenSignUp = onOpenSignUp
    }

    var body: some View {
        OnboardingLogInSceneInternal(isFullscreen: isFullscreen,
                                     store: store,
                                     close: { dismiss() },
                                     onOpenSignUp: onOpenSignUp)
    }
}

struct OnboardingLogInSceneInternal: View {
    @State private var vm: OnboardingLogInViewModel

    @FocusState private var focusedField: Field?

    enum Field {
        case email
        case password
    }

    init(isFullscreen: Bool?,
         store: UserStore,
         close: @escaping () -> Void,
         onOpenSignUp: @escaping () -> Void) {
        self._vm = State(initialValue: .init(isFullscreen: isFullscreen,
                                             store: store,
                                             close: close,
                                             onOpenSignUp: onOpenSignUp))
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
        .popup(item: $vm.errorMessage) { message in
            Toast.error(message)
                .padding(.horizontal)
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .autohideIn(4)
        }
    }

    private var headerView: some View {
        HStack(spacing: .zero) {
            Button("", action: vm.goBack)
                .buttonStyle(.orangeadeIconProminent(kind: .onboarding,
                                                     icon: vm.isFullscreen
                                                         ? AppImage.Icon.close.image
                                                         : AppImage.Icon.back.image))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: vm.isFullscreen
            ? .trailing
            : .leading)
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
    @Previewable @State var userStore = UserStore()

    OnboardingLogInScene(isFullscreen: true,
                         onOpenSignUp: {})
        .environment(userStore)
}
