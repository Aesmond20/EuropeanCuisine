//
//  OnboardingSignUpScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import PopupView
import SwiftUI

struct OnboardingSignUpScene: View {
    @Environment(UserStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    private let isFullscreen: Bool?
    private let onOpenLogIn: () -> Void

    init(isFullscreen: Bool? = nil,
         onOpenLogIn: @escaping () -> Void) {
        self.isFullscreen = isFullscreen
        self.onOpenLogIn = onOpenLogIn
    }

    var body: some View {
        OnboardingSignUpSceneInternal(isFullscreen: isFullscreen,
                                      store: store,
                                      close: { dismiss() },
                                      onOpenLogIn: onOpenLogIn)
    }
}

struct OnboardingSignUpSceneInternal: View {
    @State private var vm: OnboardingSignUpViewModel

    init(isFullscreen: Bool?,
         store: UserStore,
         close: @escaping () -> Void,
         onOpenLogIn: @escaping () -> Void) {
        self._vm = State(initialValue: .init(isFullscreen: isFullscreen,
                                             store: store,
                                             close: close,
                                             onOpenLogIn: onOpenLogIn))
    }

    var body: some View {
        ScrollView {
            ZStack {
                mainView
                    .id(vm.step)
                    .transition(.asymmetric(insertion: .move(edge: vm
                                                .isGoingForward ? .trailing : .leading),
                        removal: .move(edge: vm
                            .isGoingForward ? .leading : .trailing)))
            }
            .frame(maxWidth: .infinity)
            .animation(.smooth, value: vm.step)
        }
        .scrollBounceBehavior(.basedOnSize)
        .onboardingHeader(topTrailingSplash: .init(version: .one,
                                                   kind: vm.topTrailingSplashKind)) {
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
        HStack(alignment: .center,
               spacing: Styles.headerHorizontalSpacing) {
            Button("", action: vm.goToPrevious)
                .buttonStyle(.orangeadeIconProminent(kind: .onboarding,
                                                     icon: vm.isFullscreen && vm.isFirstStep
                                                         ? AppImage.Icon.close.image
                                                         : AppImage.Icon.back.image))

            OnboardingProgress(title: .onboardingSignUpTitle,
                               current: vm.currentStep,
                               total: vm.totalStep)
                .animation(.smooth,
                           value: vm.step)
        }
        .padding(.horizontal)
    }

    private var footerView: some View {
        VStack(alignment: .center,
               spacing: Styles.footerVerticalSpacing) {
            Button(vm.actionLabel, action: vm.goToNext)
                .buttonStyle(.orangeadeProminent(kind: vm.actionKind,
                                                 isFullWidth: true))
                .disabled(vm.isActionDisabled)

            OnboardingMessageWithAction(message: .onboardingMessageQuestionHasAccount,
                                        actionMessage: .globalButtonLogInLabel,
                                        action: vm.openLogIn)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private var mainView: some View {
        switch vm.step {
        case .email:
            OnboardingSignUpEmailView(email: $vm.email,
                                      emailErrorMessages: vm.emailErrorMessages)
        case .password:
            OnboardingSignUpPasswordView(password: $vm.password,
                                         confirmPassword: $vm.confirmPassword,
                                         passwordErrorMessages: vm.passwordErrorMessages,
                                         hasUppercaseLetter: vm.passwordHasUppercaseLetter,
                                         hasLowercaseLetter: vm.passwordHasLowercaseLetter,
                                         hasAtLeastOneNumber: vm.passwordHasAtLeastOneNumber,
                                         hasAtLeastXcharacters: vm.passwordHasAtLeastXcharacters,
                                         hasPasswordMatch: vm.passwordMatch)
        case .name:
            OnboardingSignUpNameView(name: $vm.name,
                                     nameErrorMessages: vm.nameErrorMessages)
        }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let headerHorizontalSpacing = AppToken.Primitive.spacing3

    static let footerVerticalSpacing = AppToken.Primitive.spacing3
}

#Preview {
    @Previewable @State var userStore = UserStore()

    OnboardingSignUpScene(onOpenLogIn: {})
        .environment(userStore)
}
