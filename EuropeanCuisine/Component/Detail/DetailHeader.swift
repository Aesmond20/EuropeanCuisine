//
//  DetailHeader.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: Styles.verticalSpacing) {
            Text(title)
                .font(Styles.titleFont)
                .foregroundStyle(Styles.titleColor)

            Text(subtitle)
                .font(Styles.subtitleFont)
                .foregroundStyle(Styles.subtitleColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing1

    static let titleFont: Font = .system(size: 24,
                                         weight: .bold)
    static let titleColor = AppColor.Label.primary

    static let subtitleFont: Font = .system(size: 17,
                                            weight: .medium)
    static let subtitleColor = AppColor.Label.primary
}

#Preview {
    DetailHeader(title: "Ullam Autem Ut Omnis",
                 subtitle: "Quasi Suscipit")
}
