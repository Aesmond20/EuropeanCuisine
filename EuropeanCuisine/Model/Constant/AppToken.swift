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
    static let fieldIconSize: Double = 20
    static let fieldIconWeight: Font.Weight = .medium
    static let fieldLabelSize: Double = 15
    static let fieldLabelWeight: Font.Weight = .regular
    static let fieldHeight: Double = 48
    static let fieldHorizontalPadding: Double = AppToken.Primitive.padding4
    static let searchBarCornerRadius: Double = Primitive.radius2xl
    static let searchBarHeight: Double = 48
    static let buttonHeight: Double = 48
    static let buttonCornerRadius: Double = Primitive.radius2xl
    static let buttonPressedAnimation = Animation.snappy

    enum Primitive {
        // Padding

        /// padding 0 -> 0
        static let padding0: Double = 0

        /// padding 1 -> 4
        static let padding1: Double = 4

        /// padding 2 -> 8
        static let padding2: Double = 8

        /// padding 3 -> 12
        static let padding3: Double = 12

        /// padding 4 -> 16
        static let padding4: Double = 16

        /// padding 5 -> 20
        static let padding5: Double = 20

        /// padding 6 -> 24
        static let padding6: Double = 24

        /// padding 8 -> 32
        static let padding8: Double = 32

        /// padding 10 -> 40
        static let padding10: Double = 40

        /// padding 12 -> 48
        static let padding12: Double = 48

        /// padding 16 -> 64
        static let padding16: Double = 64

        /// padding 20 -> 80
        static let padding20: Double = 80

        // Radius

        /// radius None
        static let radiusNone: Double = 0

        /// radius XS = 2
        static let radiusXs: Double = 2

        /// radius Sm = 4
        static let radiusSm: Double = 4

        /// radius Md = 6
        static let radiusMd: Double = 6

        /// radius Lg = 8
        static let radiusLg: Double = 8

        /// radius XL = 12
        static let radiusXl: Double = 12

        /// radius 2XL = 16
        static let radius2xl: Double = 16

        /// radius 3XL = 20
        static let radius3xl: Double = 20

        /// radius 4XL = 24
        static let radius4xl: Double = 24

        /// radius 5XL = 32
        static let radius5xl: Double = 32

        /// radius Full
        static let radiusFull: Double = 9999

        // Spacing

        /// spacing 0 -> 0
        static let spacing0: Double = 0

        /// spacing 0.5 -> 2
        static let spacing05: Double = 2

        /// spacing 1 -> 4
        static let spacing1: Double = 4

        /// spacing 2 -> 8
        static let spacing2: Double = 8

        /// spacing 3 -> 12
        static let spacing3: Double = 12

        /// spacing 4 -> 16
        static let spacing4: Double = 16

        /// spacing 5 -> 20
        static let spacing5: Double = 20

        /// spacing 6 -> 24
        static let spacing6: Double = 24

        /// spacing 8 -> 32
        static let spacing8: Double = 32

        /// spacing 10 -> 40
        static let spacing10: Double = 40

        /// spacing 12 -> 48
        static let spacing12: Double = 48

        /// spacing 16 -> 64
        static let spacing16: Double = 64

        /// spacing 20 -> 80
        static let spacing20: Double = 80
    }
}
