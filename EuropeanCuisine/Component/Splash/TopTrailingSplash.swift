//
//  TopTrailingSplash.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 05/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct TopTrailingSplash: View {
    let version: Version
    let kind: Kind

    enum Version {
        case one
        case two
        case three
    }

    enum Kind {
        case primary
        case secondary
        case tertiary
        case quaternary
    }

    var body: some View {
        image
            .renderingMode(.template)
            .foregroundStyle(color)
    }

    private var image: Image {
        switch version {
        case .one:
            AppImage.topTrailingSplashV1
        case .two:
            AppImage.topTrailingSplashV2
        case .three:
            AppImage.topTrailingSplashV3
        }
    }

    private var color: Color {
        switch kind {
        case .primary:
            Styles.primary
        case .secondary:
            Styles.secondary
        case .tertiary:
            Styles.tertiary
        case .quaternary:
            Styles.quaternary
        }
    }
}

fileprivate enum Styles {
    static let primary = AppColor.accentPrimary
    static let secondary = AppColor.accentSecondary
    static let tertiary = AppColor.accentTertiary
    static let quaternary = AppColor.accentQuaternary
}

#Preview {
    TopTrailingSplash(version: .two, kind: .quaternary)
}
