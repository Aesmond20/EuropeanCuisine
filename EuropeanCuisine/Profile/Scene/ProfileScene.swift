//
//  ProfileScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ProfileScene: View {
    let user: User = .example

    var body: some View {
        ScrollView {
            VStack(alignment: .center,
                   spacing: Styles.verticalSpacing) {
                ProfileHeader(name: user.name,
                              email: user.email,
                              pictureURL: user.pictureURL)

                ProfileList(onChangePassword: {},
                            onShowLegal: {},
                            onLogOut: {})
            }
            .padding(.horizontal)
            .padding(.vertical, Styles.verticalPadding)
        }
        .scrollBounceBehavior(.basedOnSize)
        .background(Styles.background)
        .sceneHeader(.profileTitle,
                     topTrailingSplash: .init(version: .three,
                                              kind: .primary),
                     onEdit: {})
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
}

#Preview {
    ProfileScene()
}
