//
//  ProfileScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ProfileScene: View {
    @Environment(UserStore.self) private var userStore

    var body: some View {
        ProfileSceneInternal(store: userStore)
    }
}

struct ProfileSceneInternal: View {
    @State private var vm: ProfileViewModel

    init(store: UserStore) {
        self._vm = State(initialValue: .init(store: store))
    }

    var body: some View {
        Group {
            if let user = vm.user {
                ScrollView {
                    VStack(alignment: .center,
                           spacing: Styles.verticalSpacing) {
                        ProfileHeader(name: user.name,
                                      email: user.email,
                                      pictureURL: user.pictureURL)

                        ProfileList(onChangePassword: {},
                                    onShowLegal: {},
                                    onLogOut: vm.logOutUser)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, Styles.verticalPadding)
                    .scrollBounceBehavior(.basedOnSize)
                }
            } else {
                ContentEmptyView("Not log in_PLC",
                                 systemImage: AppImage.Icon.notLogIn.systemName,
                                 description: "You cannot see your profile because you are not logged in._PLC") {
                    HStack(spacing: Styles.emptyActionsSpacing) {
                        Button(.globalButtonSignUpLabel, action: vm.showSignUpUser)
                            .buttonStyle(.orangeadeProminent(kind: .primary))

                        Button(.globalButtonLogInLabel, action: vm.showLogInUser)
                            .buttonStyle(.orangeadeProminent(kind: .tertiary))
                    }
                }
            }
        }
        .background(Styles.background)
        .if(!vm.hasUser) {
            $0
                .sceneHeader(.profileTitle,
                             topTrailingSplash: .init(version: .three,
                                                      kind: .primary))
        }
        .if(vm.hasUser) {
            $0
                .sceneHeader(.profileTitle,
                             topTrailingSplash: .init(version: .three,
                                                      kind: .primary),
                             onEdit: {})
        }
        .fullScreenCover(isPresented: $vm.isSignUpPresented) {
            OnboardingSignUpScene(isFullscreen: true,
                                  onOpenLogIn: {
                                      Task {
                                          try? await Task.sleep(for: .seconds(1))
                                          vm.showLogInUser()
                                      }
                                  })
        }
        .fullScreenCover(isPresented: $vm.isLogInPresented) {
            OnboardingLogInScene(isFullscreen: true,
                                 onOpenSignUp: {
                                     Task {
                                         try? await Task.sleep(for: .seconds(1))
                                         vm.showSignUpUser()
                                     }
                                 })
        }
    }
}

fileprivate struct ProfileList: View {
    let onChangePassword: () -> Void
    let onShowLegal: () -> Void
    let onLogOut: () -> Void

    var body: some View {
        VStack(alignment: .leading,
               spacing: .zero) {
            ProfileListRow(icon: AppImage.Icon.language.image,
                           label: .profileListLanguageLabel) {
                Picker("",
                       selection: .constant("First")) {
                    Text("First")
                        .tag("First")

                    Text("Second")
                        .tag("Second")

                    Text("Third")
                        .tag("Third")
                }
                .tint(Styles.languageTint)
            }
            .frame(height: Styles.rowHeight, alignment: .leading)
            .padding(.horizontal, Styles.rowHorizontalPadding)

            Divider()

            ProfileListRow(icon: AppImage.Icon.password.image,
                           label: .profileListChangePasswordLabel,
                           kind: .link,
                           action: onChangePassword)
                .frame(height: Styles.rowHeight, alignment: .leading)
                .padding(.horizontal, Styles.rowHorizontalPadding)

            Divider()

            ProfileListRow(icon: AppImage.Icon.legal.image,
                           label: .profileListLegalLabel,
                           kind: .link,
                           action: onShowLegal)
                .frame(height: Styles.rowHeight, alignment: .leading)
                .padding(.horizontal, Styles.rowHorizontalPadding)

            Divider()

            ProfileListRow(icon: AppImage.Icon.logOut.image,
                           iconColor: AppColor.destructive,
                           label: .globalButtonLogOutLabel,
                           kind: .action,
                           action: onLogOut)
                .frame(height: Styles.rowHeight, alignment: .leading)
                .padding(.horizontal, Styles.rowHorizontalPadding)
        }
        .background {
            Styles.listShape
                .fill(Styles.listBackground)
        }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let verticalPadding = AppToken.Primitive.padding2
    static let verticalSpacing = AppToken.Primitive.spacing8

    static let listShape = RoundedRectangle(cornerRadius: AppToken.Primitive.radius4xl)
    static let listBackground = AppColor.surface

    static let rowHeight: Double = 52
    static let rowHorizontalPadding = AppToken.Primitive.padding4

    static let languageTint = AppColor.Label.secondary

    static let emptyActionsSpacing = AppToken.Primitive.spacing4
}

#Preview {
    @Previewable @State var store = UserStore()

    NavigationStack {
        ProfileScene()
    }
    .environment(store)
}
