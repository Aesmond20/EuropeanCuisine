//
//  OnboardingProgress.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 27/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingProgress: View {
    private let title: String
    private let current: UInt8
    private let total: UInt8

    init(title: String, current: UInt8, total: UInt8) {
        self.title = title
        self.current = current
        self.total = total
    }

    init(title: LocalizedStringResource,
         current: UInt8,
         total: UInt8) {
        self.title = String(localized: title)
        self.current = current
        self.total = total
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Styles.verticalSpacing) {
            Text(title)
                .font(Styles.titleFont)
                .textCase(Styles.titleTextCase)
                .foregroundStyle(Styles.titleColor)

            OnboardingProgressBar(current: current, total: total)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing2

    static let titleFont: Font = .system(size: 12,
                                         weight: .semibold)
    static let titleTextCase: Text.Case = .uppercase
    static let titleColor = AppColor.accentSecondary
}

#Preview {
    VStack(alignment: .leading,
           spacing: 40) {
        OnboardingProgress(title: "Vel Repellat",
                           current: 1,
                           total: 4)

        OnboardingProgress(title: "Eum Molestiae",
                           current: 3,
                           total: 5)
    }
    .padding()
    .background(AppColor.Scene.background)
}
