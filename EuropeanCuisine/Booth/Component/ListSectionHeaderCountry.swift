//
//  ListSectionHeaderCountry.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ListSectionHeaderCountry: View {
    let code: String
    let name: String

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.horizontalSpacing) {
            Image(flagName)
                .resizable()
                .scaledToFit()
                .frame(width: Styles.flagWidth,
                       alignment: .center)
                .clipShape(Styles.flagShape)
                .overlay {
                    Styles.flagShape
                        .strokeBorder(Styles.flagBorderColor,
                                      lineWidth: Styles.flagBorderWidth)
                }

            Text(name)
                .font(Styles.labelFont)
                .foregroundStyle(Styles.labelColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var flagName: String {
        "flag_\(code)"
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing3

    static let labelFont: Font = .system(size: 20,
                                         weight: .bold)
    static let labelColor = AppColor.Label.title

    static let flagWidth: Double = 32
    static let flagCornerRadius = AppToken.Primitive.radiusMd
    static let flagShape = RoundedRectangle(cornerRadius: flagCornerRadius)
    static let flagBorderColor = AppColor.imageBorder
    static let flagBorderWidth: Double = 1
}

#Preview {
    VStack(alignment: .leading) {
        ListSectionHeaderCountry(code: "FRA", name: "France")

        ListSectionHeaderCountry(code: "GBR", name: "Grande-Bretagne")

        ListSectionHeaderCountry(code: "ESP", name: "Espagne")
    }
    .padding()
}
