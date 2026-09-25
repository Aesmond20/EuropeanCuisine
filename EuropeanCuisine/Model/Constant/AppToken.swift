//
//  AppToken.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 22/09/2026.
//

import SwiftUI

enum AppToken {
    static let cornerRadius: Double = Primitive.radius2xl
    static let fieldBorderWidth: Double = 2
    static let fieldLabelSize: Double = 15
    static let fieldLabelWeight: Double = 400
    static let fieldHeight: Double = 48
    static let fieldHorizontalPadding: Double = 16
    static let searchBarCornerRadius: Double = Primitive.radius2xl
    static let searchBarHeight: Double = 48
    static let buttonHeight: Double = 48
    static let buttonCornerRadius: Double = Primitive.radius2xl
    static let buttonPressedAnimation = Animation.snappy

    enum Primitive {
        // Padding
        static let padding0: Double = 0
        static let padding1: Double = 4
        static let padding2: Double = 8
        static let padding3: Double = 12
        static let padding4: Double = 16
        static let padding5: Double = 20
        static let padding6: Double = 24
        static let padding8: Double = 32
        static let padding10: Double = 40
        static let padding12: Double = 48
        static let padding16: Double = 64
        static let padding20: Double = 80

        // Radius
        static let radiusNone: Double = 0
        static let radiusXs: Double = 2
        static let radiusSm: Double = 4
        static let radiusMd: Double = 6
        static let radiusLg: Double = 8
        static let radiusXl: Double = 12
        static let radius2xl: Double = 16
        static let radius3xl: Double = 20
        static let radius4xl: Double = 24
        static let radius5xl: Double = 32
        static let radiusFull: Double = 9999

        // Spacing
        static let spacing0: Double = 0
        static let spacing05: Double = 2
        static let spacing1: Double = 4
        static let spacing2: Double = 8
        static let spacing3: Double = 12
        static let spacing4: Double = 16
        static let spacing5: Double = 20
        static let spacing6: Double = 24
        static let spacing8: Double = 32
        static let spacing10: Double = 40
        static let spacing12: Double = 48
        static let spacing16: Double = 64
        static let spacing20: Double = 80
    }
}
