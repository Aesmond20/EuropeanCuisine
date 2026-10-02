//
//  OnboardingStartScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingStartScene: View {
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
                Button(.globalButtonSignUpLabel, action: {})
                    .buttonStyle(.orangeadeProminent(kind: .primary,
                                                     isFullWidth: true))

                Button(.globalButtonLogInLabel, action: {})
                    .buttonStyle(.orangeadeProminent(kind: .secondary,
                                                     isFullWidth: true))
            }
            .padding([.top, .horizontal])
        }
        .background {
            Styles.background
                .ignoresSafeArea(.all)
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
    OnboardingStartScene()
}
