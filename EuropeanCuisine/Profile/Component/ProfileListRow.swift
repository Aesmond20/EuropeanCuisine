//
//  ProfileListRow.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 03/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ProfileListRow: View {
    private let icon: Image
    private let iconColor: Color
    private let label: String
    private let kind: Kind
    private let action: (() -> Void)?
    private let trailingContent: AnyView?

    init(icon: Image,
         iconColor: Color = Styles.iconColor,
         label: String,
         kind: Kind,
         action: @escaping () -> Void) {
        self.icon = icon
        self.iconColor = iconColor
        self.label = label
        self.kind = kind
        self.trailingContent = nil
        self.action = action
    }

    init(icon: Image,
         iconColor: Color = Styles.iconColor,
         label: LocalizedStringResource,
         kind: Kind,
         action: @escaping () -> Void) {
        self.icon = icon
        self.iconColor = iconColor
        self.label = String(localized: label)
        self.kind = kind
        self.trailingContent = nil
        self.action = action
    }

    init(icon: Image,
         iconColor: Color = Styles.iconColor,
         label: String,
         trailing: () -> some View) {
        self.icon = icon
        self.iconColor = iconColor
        self.label = label
        self.kind = .withTrailing
        self.trailingContent = AnyView(trailing())
        self.action = nil
    }

    init(icon: Image,
         iconColor: Color = Styles.iconColor,
         label: LocalizedStringResource,
         trailing: () -> some View) {
        self.icon = icon
        self.iconColor = iconColor
        self.label = String(localized: label)
        self.kind = .withTrailing
        self.trailingContent = AnyView(trailing())
        self.action = nil
    }

    enum Kind {
        case link
        case action
        case withTrailing
    }

    var body: some View {
        switch kind {
        case .link:
            ListRowLink(icon: icon,
                        iconColor: iconColor,
                        label: label,
                        action: { action?() })
        case .action:
            ListRowAction(icon: icon,
                          iconColor: iconColor,
                          label: label,
                          action: { action?() })
        case .withTrailing:
            ListRowWithTrailing(icon: icon,
                                iconColor: iconColor,
                                label: label,
                                trailing: trailingContent)
        }
    }
}

fileprivate struct ListRowLink: View {
    let icon: Image
    let iconColor: Color
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: .zero) {
                HStack(alignment: .center,
                       spacing: Styles.iconLabelSpacing) {
                    icon
                        .font(Styles.iconFont)
                        .foregroundStyle(iconColor)
                        .frame(width: Styles.iconMaxWidth,
                               alignment: .center)

                    Text(label)
                        .font(Styles.labelFont)
                        .foregroundStyle(Styles.labelColor)
                }

                Spacer(minLength: Styles.horizontalSpacing)

                AppImage.Icon.listDisclosure.image
                    .font(Styles.disclosureFont)
                    .foregroundStyle(Styles.disclosureColor)
            }
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct ListRowAction: View {
    let icon: Image
    let iconColor: Color
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center,
                   spacing: Styles.iconLabelSpacing) {
                icon
                    .font(Styles.iconFont)
                    .foregroundStyle(iconColor)
                    .frame(width: Styles.iconMaxWidth,
                           alignment: .center)

                Text(label)
                    .font(Styles.labelFont)
                    .foregroundStyle(Styles.labelColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct ListRowWithTrailing: View {
    let icon: Image
    let iconColor: Color
    let label: String
    let trailing: AnyView?

    var body: some View {
        HStack(alignment: .center, spacing: .zero) {
            HStack(alignment: .center,
                   spacing: Styles.iconLabelSpacing) {
                icon
                    .font(Styles.iconFont)
                    .foregroundStyle(iconColor)
                    .frame(width: Styles.iconMaxWidth,
                           alignment: .center)

                Text(label)
                    .font(Styles.labelFont)
                    .foregroundStyle(Styles.labelColor)
            }

            Spacer(minLength: Styles.horizontalSpacing)

            if let trailing {
                trailing
            }
        }
    }
}

fileprivate enum Styles {
    static let horizontalSpacing = AppToken.Primitive.spacing3

    static let iconLabelSpacing = AppToken.Primitive.spacing2

    static let iconMaxWidth: Double = 28
    static let iconFont: Font = .system(size: 17,
                                        weight: .medium)
    static let iconColor = AppColor.Label.primary
    static let iconDestructiveColor = AppColor.Label.primary

    static let labelFont: Font = .system(size: 17,
                                         weight: .medium)
    static let labelColor = AppColor.Label.primary

    static let disclosureFont: Font = .system(size: 15,
                                              weight: .medium)
    static let disclosureColor = AppColor.Label.secondary
}

#Preview {
    VStack(alignment: .leading, spacing: 32) {
        ProfileListRow(icon: AppImage.Icon.edit.image,
                       label: "Unde Sunt",
                       kind: .link,
                       action: {})

        Divider()

        ProfileListRow(icon: AppImage.Icon.edit.image,
                       iconColor: .red,
                       label: "Deserunt Dolorum",
                       kind: .action,
                       action: {})

        Divider()

        ProfileListRow(icon: AppImage.Icon.book.image,
                       label: "Itaque") {
            Picker("",
                   selection: .constant("First")) {
                Text("First")
                    .tag("First")

                Text("Second")
                    .tag("Second")

                Text("Third")
                    .tag("Third")
            }
        }
    }
    .padding()
}
