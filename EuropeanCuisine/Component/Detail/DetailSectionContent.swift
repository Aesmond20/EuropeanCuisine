//
//  DetailSectionContent.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailSectionContent: View {
    let title: String
    let content: AnyView

    init(title: String,
         content: () -> some View) {
        self.title = title
        self.content = AnyView(content())
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Styles.verticalSpacing) {
            DetailSectionTitle(title)

            content
        }
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing2
}

#Preview {
    DetailSectionContent(title: "Voluptate Earum Error Tempora") {
        Button("Test") {}
    }
}
