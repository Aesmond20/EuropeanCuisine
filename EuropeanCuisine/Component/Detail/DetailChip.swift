//
//  DetailChip.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailChip: View {
    private let label: String

    init(_ label: String) {
        self.label = label
    }

    var body: some View {
        Text(label)
            .font(Styles.labelFont)
            .foregroundStyle(Styles.labelColor)
            .padding(.horizontal, Styles.horizontalPadding)
            .padding(.vertical, Styles.verticalPadding)
            .background(Styles.background, in: Styles.shape)
            .overlay {
                Styles.shape
                    .strokeBorder(Styles.borderColor,
                                  lineWidth: Styles.borderWidth)
            }
    }
}

fileprivate enum Styles {
    static let shape = Capsule()
    static let background = AppColor.accentContrast
    static let horizontalPadding = AppToken.Primitive.padding4
    static let verticalPadding = AppToken.Primitive.padding2
    static let borderColor = AppColor.accentSecondary.opacity(0.16)
    static let borderWidth: Double = 1

    static let labelFont: Font = .system(size: 15,
                                         weight: .medium)
    static let labelColor = AppColor.accentSecondary
}

#Preview {
    DetailChip("Qui Laborum")
        .padding()
        .background(AppColor.Scene.background)
}
