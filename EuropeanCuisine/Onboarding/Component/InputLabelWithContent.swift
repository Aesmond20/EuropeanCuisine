//
//  InputLabelWithContent.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct InputLabelWithContent<Content: View>: View {
    private let label: String
    private let errorMessages: [String]
    private let content: Content

    init(
        label: String,
        errorMessages: [String] = [],
        content: () -> Content
    ) {
        self.label = label
        self.errorMessages = errorMessages
        self.content = content()
    }
    
    init(
        label: LocalizedStringResource,
        errorMessages: [String] = [],
        content: () -> Content
    ) {
        self.label = String(localized: label)
        self.errorMessages = errorMessages
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Styles.verticalSpacing) {
            Text(label)
                .font(Styles.labelFont)
                .foregroundStyle(Styles.labelColor)

            content

            VStack(alignment: .leading,
                   spacing: Styles.verticalSpacing) {
                ForEach(errorMessages.indices, id: \.self) {
                    Text(errorMessages[$0])
                        .font(Styles.errorMessageFont)
                        .foregroundStyle(Styles.errorMessageColor)
                }
            }
        }
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing1

    static let labelFont: Font = .system(size: 13,
                                         weight: .medium)
    static let labelColor = AppColor.Label.primary

    static let errorMessageFont: Font = .system(size: 13,
                                                weight: .medium)
    static let errorMessageColor = AppColor.destructive
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused: Bool

    InputLabelWithContent(label: "Repudiandae Vitae",
                          errorMessages: [
                              "Ut aut consequatur et ut quod voluptas est cumque qui.",
                              "Et earum necessitatibus ut ullam itaque facere nihil.",
                          ]) {
        VStack(spacing: 12) {
            TextInput("Email", text: $text,
                      icon: AppImage.Icon.filter.image,
                      isFocused: isFocused)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)

            Text("Harum quam assumenda aperiam.")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    .padding()
    .background(AppColor.Scene.background)
}
