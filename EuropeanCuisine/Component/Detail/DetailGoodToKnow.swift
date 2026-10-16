//
//  DetailGoodToKnow.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailGoodToKnow: View {
    let title: String
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool

    init(title: String,
         isVegan: Bool,
         isPRM: Bool,
         isFamilyFriendly: Bool) {
        self.title = title
        self.isVegan = isVegan
        self.isPRM = isPRM
        self.isFamilyFriendly = isFamilyFriendly
    }

    init(title: LocalizedStringResource,
         isVegan: Bool,
         isPRM: Bool,
         isFamilyFriendly: Bool) {
        self.title = String(localized: title)
        self.isVegan = isVegan
        self.isPRM = isPRM
        self.isFamilyFriendly = isFamilyFriendly
    }

    var body: some View {
        DetailSectionContent(title: title) {
            VStack(alignment: .leading,
                   spacing: Styles.verticalSpacing) {
                if isVegan {
                    DetailIconLabel(icon: AppImage.Icon.isVegan.image,
                                    label: .goodToKnowVeganFriendly)
                }

                if isPRM {
                    DetailIconLabel(icon: AppImage.Icon.isPRM.image,
                                    label: .goodToKnowPrm)
                }

                if isFamilyFriendly {
                    DetailIconLabel(icon: AppImage.Icon.isFamilyFriendly.image,
                                    label: .goodToKnowFamilyFriendly)
                }
            }
        }
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing2
}

#Preview {
    DetailGoodToKnow(title: "Good to Know",
                     isVegan: true,
                     isPRM: true,
                     isFamilyFriendly: true)
        .padding()
}
