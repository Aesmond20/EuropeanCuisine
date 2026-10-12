//
//  DetailSectionParagraph.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailSectionParagraph: View {
    let title: String
    let paragraph: String

    init(title: String, paragraph: String) {
        self.title = title
        self.paragraph = paragraph
    }

    init(title: LocalizedStringResource, paragraph: String) {
        self.title = String(localized: title)
        self.paragraph = paragraph
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Styles.verticalSpacing) {
            DetailSectionTitle(title)

            Text(paragraph)
                .font(Styles.paragraphFont)
                .foregroundStyle(Styles.paragraphColor)
        }
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing2

    static let paragraphFont: Font = .system(size: 17,
                                             weight: .regular)
    static let paragraphColor = AppColor.Label.primary
}

#Preview {
    DetailSectionParagraph(title: "Laborum Fugiat Facilis Atque",
                           paragraph: "Quae velit provident officiis voluptatem commodi labore. Illum rerum aliquid rerum sed qui.")
        .padding()
}
