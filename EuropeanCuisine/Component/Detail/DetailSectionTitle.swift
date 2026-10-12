//
//  DetailSectionTitle.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct DetailSectionTitle: View {
    private let title: String

    init(_ title: String) {
        self.title = title
    }

    init(_ title: LocalizedStringResource) {
        self.title = String(localized: title)
    }

    var body: some View {
        Text(title)
            .font(Styles.titleFont)
            .foregroundStyle(Styles.titleColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate enum Styles {
    static let titleFont: Font = .system(size: 20,
                                         weight: .semibold)
    static let titleColor = AppColor.Label.primary
}

#Preview {
    DetailSectionTitle("Omnis Et Velit Perferendis")
}
