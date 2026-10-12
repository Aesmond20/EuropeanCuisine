//
//  DetailInlineInfo.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailInlineInfo: View {
    let icon: Image
    let label: String

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.horizontalSpacing) {
            icon
                .font(Styles.iconFont)
                .foregroundStyle(Styles.iconColor)
                .frame(width: Styles.iconContainerWidth,
                       alignment: .center)

            Text(label)
                .font(Styles.labelFont)
                .foregroundStyle(Styles.labelColor)
        }
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing2

    static let iconFont: Font = .system(size: 18,
                                        weight: .medium)
    static let iconColor = AppColor.accentPrimary
    static let iconContainerWidth: Double = 30

    static let labelFont: Font = .system(size: 17,
                                         weight: .medium)
    static let labelColor = AppColor.Label.primary
}

#Preview {
    DetailInlineInfo(icon: AppImage.Icon.boothLocation.image,
                     label: "Adipisci Qui")
}
