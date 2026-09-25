//
//  Font+extension.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

extension Font {
    enum DosisWeight {
        case extraLight
        case light
        case regular
        case medium
        case semibold
        case bold
        case extraBold
    }

    static func dosis(size: Double,
                      weight: DosisWeight) -> Font {
        switch weight {
        case .extraLight:
            .custom("Dosis-ExtraLight", size: size)
        case .light:
            .custom("Dosis-Light",
                    size: size)
        case .regular:
            .custom("Dosis-Regular",
                    size: size)
        case .medium:
            .custom("Dosis-Medium",
                    size: size)
        case .semibold:
            .custom("Dosis-SemiBold",
                    size: size)
        case .bold:
            .custom("Dosis-Bold",
                    size: size)
        case .extraBold:
            .custom("Dosis-ExtraBold", size: size)
        }
    }
}

#Preview {
    VStack {
        Text("Text Extra-Light")
            .font(.dosis(size: 24,
                         weight: .extraLight))

        Text("Text Light")
            .font(.dosis(size: 24,
                         weight: .light))

        Text("Text Regular")
            .font(.dosis(size: 24,
                         weight: .regular))

        Text("Text Medium")
            .font(.dosis(size: 24,
                         weight: .medium))

        Text("Text Semi-Bold")
            .font(.dosis(size: 24,
                         weight: .semibold))

        Text("Text Bold")
            .font(.dosis(size: 24,
                         weight: .bold))

        Text("Text Extra-Bold")
            .font(.dosis(size: 24,
                         weight: .extraBold))
    }
}
