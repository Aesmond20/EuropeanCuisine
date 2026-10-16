//
//  OnboardingStartScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingStartScene: View {
    @Environment(UserStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        OnboardingStartSceneInternal(store: store,
                                     close: { dismiss() })
    }
}

struct OnboardingStartSceneInternal: View {
    @State private var vm: OnboardingStartViewModel

    init(store: UserStore,
         close: @escaping () -> Void) {
        self._vm = State(initialValue: .init(store: store, close: close))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Spacer()

            VStack(alignment: .center,
                   spacing: Styles.verticalSpacing) {
                AppImage.onboardingAppName
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: Styles.titleWidth)

                Text(.onboardingStartAppTagline)
                    .font(Styles.taglineFont)
                    .foregroundStyle(Styles.taglineColor)
                    .multilineTextAlignment(Styles.taglineAlignment)

                AppImage.onboardingAppHero
                    .resizable()
                    .scaledToFit()
            }

            Spacer()

            VStack(spacing: Styles.actionsVerticalSpacing) {
                Button(.globalButtonSignUpLabel, action: vm.showSignUp)
                    .buttonStyle(.orangeadeProminent(kind: .primary,
                                                     isFullWidth: true))

                Button(.globalButtonLogInLabel, action: vm.showLogIn)
                    .buttonStyle(.orangeadeProminent(kind: .secondary,
                                                     isFullWidth: true))
            }
            .padding([.top, .horizontal])
        }
        .background {
            Styles.background
                .ignoresSafeArea(.all)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Spacer()

                Button("", action: vm.goBack)
                    .buttonStyle(.orangeadeIconProminent(kind: .onboarding,
                                                         icon: AppImage.Icon.close.image))
            }
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $vm.isSignUpPresented) {
            OnboardingSignUpScene(onOpenLogIn: {
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    vm.showLogIn()
                }
            })
        }
        .navigationDestination(isPresented: $vm.isLogInPresented) {
            OnboardingLogInScene(onOpenSignUp: {
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    vm.showSignUp()
                }
            })
        }
        .onChange(of: vm.store.token) { _, _ in
            vm.goBack()
        }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let verticalSpacing = AppToken.Primitive.spacing6

    static let titleWidth: Double = 300

    static let taglineFont: Font = .dosis(size: 28,
                                          weight: .extraBold)
    static let taglineColor = AppColor.Label.title
    static let taglineAlignment: TextAlignment = .center

    static let actionsVerticalSpacing = AppToken.Primitive.spacing4
}

#Preview {
    @Previewable @State var store = UserStore()

    NavigationStack {
        OnboardingStartScene()
    }
    .environment(store)
}

#Preview("From other view") {
    @Previewable @State var store = UserStore()
    @Previewable @State var isCoverOpen = false

    VStack {
        Button("Open Onboarding") {
            isCoverOpen = true
        }
    }
    .frame(maxWidth: .infinity,
           maxHeight: .infinity,
           alignment: .center)
    .fullScreenCover(isPresented: $isCoverOpen) {
        NavigationStack {
            OnboardingStartScene()
        }
        .environment(store)
    }
}
