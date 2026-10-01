//
//  OnboardingMessageWithAction.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 01/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingMessageWithAction: View {
    let message: String
    let actionMessage: String
    let action: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: Styles.horizontalSpacing) {
            Text(message)
                .font(Styles.messageFont)
                .foregroundStyle(Styles.messageColor)

            Button(action: action) {
                Text(actionMessage)
                    .font(Styles.actionFont)
                    .foregroundStyle(Styles.actionColor)
                    .contentShape(.rect)
            }
            .buttonStyle(.plain)
        }
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing2

    static let messageFont: Font = .system(size: 15,
                                           weight: .regular)
    static let messageColor = AppColor.Label.primary

    static let actionFont: Font = .system(size: 15,
                                          weight: .semibold)
    static let actionColor = AppColor.accentPrimary
}

#Preview {
    OnboardingMessageWithAction(message: "Ea nulla qui praesentium",
                                actionMessage: "Necessitatibus",
                                action: {})
}
