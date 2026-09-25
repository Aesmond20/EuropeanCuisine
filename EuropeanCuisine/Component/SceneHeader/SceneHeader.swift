//
//  SceneHeader.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct SceneHeader: View {
    private let title: String
    private let onEdit: (() -> Void)?

    init(title: String) {
        self.title = title
        self.onEdit = nil
    }

    init(title: String,
         onEdit: @escaping () -> Void) {
        self.title = title
        self.onEdit = onEdit
    }

    var body: some View {
        HStack(alignment: .center,
               spacing: .zero) {
            HStack(alignment: .center,
                   spacing: Styles.horizontalSpacing) {
                Text(title)
                    .font(Styles.titleFont)
                    .foregroundStyle(Styles.titleColor)

                AppImage.branchIcon
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Styles.branchColor)
                    .frame(height: Styles.branchHeight)
            }

            if let onEdit {
                Spacer(minLength: Styles.horizontalSpacing)

                Button("Edit", action: onEdit)
                    .buttonStyle(.orangeadeIconProminent(kind: .tertiary,
                                                         icon: AppImage.Icon.edit.image))
            }
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing3

    static let titleColor = AppColor.Label.title
    static let titleFont: Font = .dosis(size: 32,
                                        weight: .bold)

    static let branchColor = AppColor.accentPrimary
    static let branchHeight: Double = 32
}

#Preview {
    VStack(alignment: .leading, spacing: 40) {
        SceneHeader(title: "Possimus")

        SceneHeader(title: "Possimus Molestias") {
            print("Test")
        }
    }
    .padding()
}
