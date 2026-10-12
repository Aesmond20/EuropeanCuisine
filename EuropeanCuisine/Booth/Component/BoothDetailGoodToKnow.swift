//
//  BoothDetailGoodToKnow.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothDetailGoodToKnow: View {
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool

    var body: some View {
        DetailSectionContent(title: "Good to Know_PLC") {
            VStack(alignment: .leading,
                   spacing: Styles.verticalSpacing) {
                if isVegan {
                    DetailIconLabel(icon: AppImage.Icon.isVegan.image,
                                    label: "Vegan friendly_PLC")
                }

                if isPRM {
                    DetailIconLabel(icon: AppImage.Icon.isPRM.image,
                                    label: "Wheelchair accessible_PLC")
                }

                if isFamilyFriendly {
                    DetailIconLabel(icon: AppImage.Icon.isFamilyFriendly.image,
                                    label: "Family friendly_PLC")
                }
            }
        }
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing2
}

#Preview {
    BoothDetailGoodToKnow(isVegan: true,
                          isPRM: true,
                          isFamilyFriendly: true)
        .padding()
}
