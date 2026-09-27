//
//  OnboardingHeader.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 27/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingHeader: View {
    private let title: String
    private let subtitle: String?

    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Styles.verticalSpacing) {
            HStack(alignment: .center,
                   spacing: Styles.horizontalSpacing) {
                Text(title)
                    .font(Styles.titleFont)
                    .foregroundStyle(Styles.titleColor)

                AppImage.branchIcon
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Styles.branchColor)
                    .frame(height: Styles.branchHeight)
            }

            if let subtitle {
                Text(subtitle)
                    .font(Styles.subtitleFont)
                    .foregroundStyle(Styles.subtitleColor)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing3
    static let horizontalSpacing = AppToken.Primitive.spacing3

    static let titleFont: Font = .dosis(size: 24,
                                        weight: .bold)
    static let titleColor = AppColor.Label.title

    static let branchColor = AppColor.accentPrimary
    static let branchHeight: Double = 24

    static let subtitleFont: Font = .system(size: 15,
                                            weight: .regular)
    static let subtitleColor = AppColor.Label.title
}

#Preview {
    VStack {
        OnboardingHeader(title: "Placeat Dicta")

        OnboardingHeader(title: "Inventore Culpa",
                         subtitle: """
                         Natus odit consequatur est quas nostrum vitae. Consectetur quos \
                         ipsum necessitatibus officia rem laborum saepe accusamus \
                         aut dignissimos corrupti error eos quia provident.
                         """)
    }
    .padding()
    .background(AppColor.Scene.background)
}
