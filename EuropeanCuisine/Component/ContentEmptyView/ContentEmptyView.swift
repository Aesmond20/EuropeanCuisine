//
//  ContentEmptyView.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ContentEmptyView: View {
    private let title: Text
    private let image: Image
    private let description: Text?
    private let accessoryView: AnyView?

    init(_ title: String,
         image: Image,
         description: String? = nil,
         @ViewBuilder accessory: () -> some View) {
        self.title = Text(title)
        self.image = image
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = AnyView(accessory())
    }

    init(_ title: String,
         image: Image,
         description: String? = nil) {
        self.title = Text(title)
        self.image = image
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = nil
    }

    init(_ title: LocalizedStringResource,
         image: Image,
         description: LocalizedStringResource? = nil,
         @ViewBuilder accessory: () -> some View) {
        self.title = Text(title)
        self.image = image
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = AnyView(accessory())
    }

    init(_ title: LocalizedStringResource,
         image: Image,
         description: LocalizedStringResource? = nil) {
        self.title = Text(title)
        self.image = image
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = nil
    }

    init(_ title: String,
         systemImage name: String,
         description: String? = nil,
         @ViewBuilder accessory: () -> some View) {
        self.title = Text(title)
        self.image = Image(systemName: name)
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = AnyView(accessory())
    }

    init(_ title: String,
         systemImage name: String,
         description: String? = nil) {
        self.title = Text(title)
        self.image = Image(systemName: name)
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = nil
    }

    init(_ title: LocalizedStringResource,
         systemImage name: String,
         description: LocalizedStringResource? = nil,
         @ViewBuilder accessory: () -> some View) {
        self.title = Text(title)
        self.image = Image(systemName: name)
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = AnyView(accessory())
    }

    init(_ title: LocalizedStringResource,
         systemImage name: String,
         description: LocalizedStringResource? = nil) {
        self.title = Text(title)
        self.image = Image(systemName: name)
        self.description = if let description {
            Text(description)
        } else {
            nil
        }
        self.accessoryView = nil
    }

    var body: some View {
        VStack(alignment: .center,
               spacing: Styles.verticalSpacing) {
            image
                .font(Styles.iconFont)
                .foregroundStyle(Styles.iconColor)

            VStack(alignment: .center,
                   spacing: Styles.labelsVerticalSpacing) {
                title
                    .font(Styles.titleFont)
                    .foregroundStyle(Styles.titleColor)
                    .multilineTextAlignment(Styles.titleTextAlignment)

                if let description {
                    description
                        .font(Styles.descriptionFont)
                        .foregroundStyle(Styles.descriptionColor)
                        .multilineTextAlignment(Styles.descriptionTextAlignment)
                }
            }

            if let accessoryView {
                accessoryView
            }
        }
        .padding(Styles.padding)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .center)
    }

    static func search(text: String) -> ContentEmptyView {
        let image: Image = AppImage.Icon.search.image
        let title: String = text.trimmed.isNotEmpty
            ? "No Results for \"\(text)\""
            : "No Results"
        let description = "Check the spelling or try a new search."

        return ContentEmptyView(title,
                                image: image,
                                description: description)
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing4
    static let padding = AppToken.Primitive.padding8

    static let iconFont: Font = .system(size: 96,
                                        weight: .medium)
    static let iconColor = AppColor.Label.secondary

    static let labelsVerticalSpacing = AppToken.Primitive.spacing3

    static let titleFont: Font = .system(size: 28,
                                         weight: .semibold)
    static let titleTextAlignment: TextAlignment = .center
    static let titleColor = AppColor.Label.primary

    static let descriptionFont: Font = .system(size: 17,
                                               weight: .regular)
    static let descriptionColor = AppColor.Label.primary
    static let descriptionTextAlignment: TextAlignment = .center
}

#Preview("title only") {
    ContentEmptyView("No Lorem Found", systemImage: "person.fill")
}

#Preview("title with desc") {
    ContentEmptyView("No Lorem Found",
                     systemImage: "person.fill",
                     description: "Incidunt ea impedit voluptatibus iste ipsum temporibus recusandae ducimus consequatur quaerat.")
}

#Preview("search") {
    ContentEmptyView.search(text: "ipsum")
}
