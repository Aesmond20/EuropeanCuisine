//
//  BoothDetailAllergens.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Flow
import SwiftUI

struct BoothDetailAllergens: View {
    let title: String
    let allergens: Set<Allergen>
    let emptyMessage: String

    init(title: String, allergens: Set<Allergen>, emptyMessage: String) {
        self.title = title
        self.allergens = allergens
        self.emptyMessage = emptyMessage
    }

    init(title: LocalizedStringResource, allergens: Set<Allergen>,
         emptyMessage: LocalizedStringResource) {
        self.title = String(localized: title)
        self.allergens = allergens
        self.emptyMessage = String(localized: emptyMessage)
    }

    var body: some View {
        DetailSectionContent(title: title) {
            Group {
                if allergens.isNotEmpty {
                    HFlow(alignment: .center,
                          itemSpacing: Styles.itemSpacing,
                          rowSpacing: Styles.itemSpacing) {
                        ForEach(sortedAllergens) { allergen in
                            DetailChip(allergen.name)
                        }
                    }
                } else {
                    Text(emptyMessage)
                        .font(Styles.emptyMessageFont)
                        .foregroundStyle(Styles.emptyMessageColor)
                }
            }
        }
    }

    private var sortedAllergens: [Allergen] {
        allergens
            .sorted(by: { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending })
    }
}

fileprivate enum Styles {
    static let itemSpacing = AppToken.Primitive.spacing2

    static let emptyMessageFont: Font = .system(size: 17,
                                                weight: .medium)
        .italic()
    static let emptyMessageColor = AppColor.Label.secondary
}

#Preview {
    BoothDetailAllergens(title: "Et Rerum",
                         allergens: [
                             .celery,
                             .cerealsContainingGluten,
                             .eggs,
                             .lupin,
                             .mustard,
                             .soybeans,
                             .sulphurDioxideAndSulphites,
                         ],
                         emptyMessage: "Eaque Et Voluptates Harum")
        .padding()
        .background(AppColor.Scene.background)
}
