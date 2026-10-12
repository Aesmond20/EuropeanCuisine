//
//  DetailIconLabel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailIconLabel: View {
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
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing2

    static let iconFont: Font = .system(size: 17,
                                        weight: .regular)
    static let iconColor = AppColor.Label.primary
    static let iconContainerWidth: Double = 22

    static let labelFont: Font = .system(size: 17,
                                         weight: .regular)
    static let labelColor = AppColor.Label.primary
}

#Preview {
    VStack {
        DetailIconLabel(icon: AppImage.Icon.isVegan.image,
                        label: "Vegan friendly")

        DetailIconLabel(icon: AppImage.Icon.isPRM.image,
                        label: "Accessible en fauteuil roulant")

        DetailIconLabel(icon: AppImage.Icon.isFamilyFriendly.image,
                        label: "Adapté aux enfants")
    }
    .padding()
}
