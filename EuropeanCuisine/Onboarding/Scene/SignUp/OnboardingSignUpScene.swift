//
//  OnboardingSignUpScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingSignUpScene: View {
    @State private var vm: OnboardingSignUpViewModel = .init()

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
        .safeAreaInset(edge: .top) {
            headerWithBlurBackground
        }
        .safeAreaInset(edge: .bottom) {
            footerWithBlurBackground
        }
        .background {
            Styles.background
                .ignoresSafeArea(.all)
        }
    }

    private var headerWithBlurBackground: some View {
        VStack(spacing: .zero) {
            Rectangle()
                .fill(.clear)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background {
                    Rectangle()
                        .fill(Styles.background)
                        .ignoresSafeArea(.all,
                                         edges: .top)
                }

            headerView
                .padding(.bottom, Styles.headerBottomPadding)
                .background {
                    Rectangle()
                        .fill(LinearGradient(colors: [
                                Styles.background.opacity(1),
                                Styles.background.opacity(1),
                                Styles.background.opacity(1),
                                Styles.background.opacity(0.64),
                            ],
                            startPoint: .top,
                            endPoint: .bottom))
                        .padding(-20)
                        .blur(radius: 10)
                        .padding(20)
                        .padding(.top, -20)
                }
        }
    }

    private var headerView: some View {
        HStack(alignment: .center,
               spacing: Styles.headerHorizontalSpacing) {
            Button("", action: vm.goToPrevious)
                .buttonStyle(.orangeadeIconProminent(kind: .onboarding,
                                                     icon: AppImage.Icon.back.image))

            OnboardingProgress(title: .onboardingSignUpTitle,
                               current: vm.currentStep,
                               total: vm.totalStep)
                .animation(.smooth,
                           value: vm.step)
        }
        .padding(.horizontal)
    }

    private var footerWithBlurBackground: some View {
        VStack(spacing: .zero) {
            footerView
                .padding(.top, Styles.footerTopPadding)
                .background {
                    Rectangle()
                        .fill(LinearGradient(colors: [
                                Styles.background.opacity(0.64),
                                Styles.background.opacity(1),
                                Styles.background.opacity(1),
                                Styles.background.opacity(1),
                            ],
                            startPoint: .top,
                            endPoint: .bottom))
                        .padding(-20)
                        .blur(radius: 10)
                        .padding(20)
                        .padding(.bottom, -20)
                }

            Rectangle()
                .fill(.clear)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .background {
                    Rectangle()
                        .fill(Styles.background)
                        .ignoresSafeArea(.all,
                                         edges: .bottom)
                }
        }
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
                                        action: {})
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
    static let headerBottomPadding = AppToken.Primitive.padding2

    static let footerVerticalSpacing = AppToken.Primitive.spacing3
    static let footerTopPadding = AppToken.Primitive.padding2
}

#Preview {
    OnboardingSignUpScene()
}
