//
//  OnboardingProgressBar.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 27/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingProgressBar: View {
    private let current: UInt8
    private let total: UInt8

    init(current: UInt8, total: UInt8) {
        var tempCurrent = current
        var tempTotal = total

        if tempCurrent < 1 {
            tempCurrent = 1
        } else if tempCurrent > tempTotal {
            tempCurrent = tempTotal
        }

        if tempTotal < tempCurrent {
            tempTotal = tempCurrent
        }

        self.current = tempCurrent
        self.total = tempTotal
    }

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.horizontalSpacing) {
            ForEach(1 ... total, id: \.self) { index in
                Capsule()
                    .fill(index <= current
                        ? Styles.backgroundIsOn
                        : Styles.backgroundIsOff)
                    .frame(height: Styles.height)
            }
        }
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing2

    static let backgroundIsOn = AppColor.accentPrimary
    static let backgroundIsOff = AppColor.accentSecondary.opacity(0.2)

    static let height: Double = 4
}

#Preview {
    VStack(spacing: 32) {
        OnboardingProgressBar(current: 1, total: 5)

        OnboardingProgressBar(current: 2, total: 3)

        OnboardingProgressBar(current: 4, total: 4)

        OnboardingProgressBar(current: 7, total: 6)
    }
}
