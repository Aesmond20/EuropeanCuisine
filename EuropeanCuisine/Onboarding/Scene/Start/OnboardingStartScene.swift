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

            Text("Escale Europe")
                .font(.largeTitle)

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

    static let actionsVerticalSpacing = AppToken.Primitive.spacing4
}

#Preview {
    OnboardingStartScene()
}
