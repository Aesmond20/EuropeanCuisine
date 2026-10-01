//
//  TextInput.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct TextInput: View {
    @Binding private var text: String
    private let icon: Image?
    private let placeholder: String
    private let isFocused: Bool
    private let isValid: Bool

    init(_ placeholder: String,
         text: Binding<String>,
         isFocused: Bool,
         isValid: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.icon = nil
        self.isFocused = isFocused
        self.isValid = isValid
    }

    init(_ placeholder: String,
         text: Binding<String>,
         icon: Image?,
         isFocused: Bool,
         isValid: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
        self.isFocused = isFocused
        self.isValid = isValid
    }

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.horizontalSpacing) {
            if let icon {
                icon
                    .font(Styles.iconFont)
                    .foregroundStyle(iconColor)
                    .frame(width: Styles.iconMaxWidth,
                           alignment: .center)
            }

            TextField("",
                      text: $text,
                      prompt: Text(placeholder)
                          .font(Styles.placeholderFont)
                          .foregroundStyle(placeholderColor))
                .font(Styles.textFont)
                .foregroundStyle(textColor)
        }
        .padding(.horizontal, Styles.horizontalPadding)
        .frame(height: Styles.height)
        .background {
            Styles.shape
                .fill(backgroundColor)
        }
        .overlay {
            Styles.shape
                .strokeBorder(borderColor,
                              lineWidth: Styles.borderWidth)
        }
    }

    private var placeholderColor: Color {
        Styles.placeholderColor
    }

    private var iconColor: Color {
        if isValid {
            Styles.successColor
        } else if isFocused {
            Styles.iconFocusedColor
        } else {
            Styles.iconColor
        }
    }

    private var textColor: Color {
        Styles.textColor
    }

    private var borderColor: Color {
        if isValid {
            Styles.successColor
        } else if isFocused {
            Styles.borderFocusedColor
        } else {
            Styles.borderColor
        }
    }

    private var backgroundColor: Color {
        Styles.background
    }
}

fileprivate enum Styles {
    static let accentColor = AppColor.accentPrimary
    static let successColor = AppColor.success

    static let cornerRadius = AppToken.cornerRadius

    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
    static let background = AppColor.fieldBackground

    static let height = AppToken.fieldHeight
    static let horizontalSpacing = AppToken.Primitive.spacing2
    static let horizontalPadding = AppToken.fieldHorizontalPadding

    static let borderColor = AppColor.fieldBorder
    static let borderFocusedColor = accentColor
    static let borderWidth = AppToken.fieldBorderWidth

    static let placeholderColor = AppColor.Label.secondary
    static let placeholderFont = textFont

    static let iconColor = AppColor.Label.secondary
    static let iconFocusedColor = accentColor
    static let iconFont: Font = .system(size: AppToken.fieldIconSize,
                                        weight: AppToken.fieldIconWeight)
    static let iconMaxWidth = AppToken.fieldIconMaxWidth

    static let textColor = AppColor.Label.primary
    static let textFont: Font = .system(size: AppToken.fieldLabelSize,
                                        weight: AppToken.fieldLabelWeight)
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused

    @Previewable @State var text2 = ""

    VStack(spacing: 32) {
        Text("First text: \(text)")

        TextInput("Eligendi Impedit",
                  text: $text,
                  icon: AppImage.Icon.edit.image,
                  isFocused: isFocused,
                  isValid: text.count == 7)
            .focused($isFocused)

        Text("Second text: \(text2)")

        TextInput("Eligendi Impedit",
                  text: $text2,
                  isFocused: true)
    }
    .padding()
    .background(AppColor.Scene.background)
}
