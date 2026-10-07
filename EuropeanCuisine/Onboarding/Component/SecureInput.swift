//
//  SecureInput.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct SecureInput: View {
    @Binding private var text: String
    private let icon: Image?
    private let placeholder: String
    private let isFocused: Bool
    private let isValid: Bool

    @State private var isSecure: Bool = true

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

    init(_ placeholder: LocalizedStringResource,
         text: Binding<String>,
         isFocused: Bool,
         isValid: Bool = false) {
        self.placeholder = String(localized: placeholder)
        self._text = text
        self.icon = nil
        self.isFocused = isFocused
        self.isValid = isValid
    }

    init(_ placeholder: LocalizedStringResource,
         text: Binding<String>,
         icon: Image?,
         isFocused: Bool,
         isValid: Bool = false) {
        self.placeholder = String(localized: placeholder)
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

            SecureFieldUIKit(placeholder: placeholder,
                             placeholderColor: Styles.placeholderColor,
                             text: $text,
                             textColor: Styles.textColor,
                             textFont: Styles.textUIFont,
                             isSecure: isSecure)

            Button {
                isSecure.toggle()
            } label: {
                Group {
                    if isSecure {
                        AppImage.Icon.showSecure.image
                    } else {
                        AppImage.Icon.hideSecure.image
                    }
                }
                .font(Styles.hideShowButtonFont)
            }
            .tint(Styles.hideShowButtonColor)
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

    private var iconColor: Color {
        if isValid {
            Styles.successColor
        } else if isFocused {
            Styles.iconFocusedColor
        } else {
            Styles.iconColor
        }
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

// swiftlint:disable:next line_length
/// https://commitstudiogs.medium.com/how-to-create-custom-context-menus-in-swiftui-textfield-with-uiviewrepresentable-861492623913
fileprivate struct SecureFieldUIKit: UIViewRepresentable {
    let placeholder: String
    let placeholderColor: UIColor
    @Binding var text: String
    var textColor: UIColor
    let textFont: UIFont
    var isSecure: Bool

    init(placeholder: String,
         placeholderColor: Color,
         text: Binding<String>,
         textColor: Color,
         textFont: UIFont,
         isSecure: Bool) {
        self.placeholder = placeholder
        self.placeholderColor = UIColor(placeholderColor)
        self._text = text
        self.textColor = UIColor(textColor)
        self.textFont = textFont
        self.isSecure = isSecure
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = isSecure
        textField.textColor = textColor
        textField.font = textFont
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [
                                                                 .foregroundColor: placeholderColor,
                                                                 .font: textFont,
                                                             ])
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.addTarget(context.coordinator,
                            action: #selector(Coordinator.textFieldDidChange), for: .editingChanged)

        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no

        return textField
    }

    func updateUIView(_ textField: UITextField, context: Context) {
        context.coordinator.parent = self

        textField.isSecureTextEntry = isSecure

        if textField.text != text {
            textField.text = text
        }

        textField.textColor = textColor
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SecureFieldUIKit

        init(_ parent: SecureFieldUIKit) {
            self.parent = parent
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        /// Évite l'effacement du texte à la première frappe
        /// quand le champ est en mode sécurisé et reprend le focus.
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            guard textField.isSecureTextEntry,
                  let current = textField.text,
                  let swiftRange = Range(range, in: current) else {
                return true
            }

            let updated = current.replacingCharacters(in: swiftRange, with: string)
            textField.text = updated
            parent.text = updated

            let offset = range.location + (string as NSString).length
            if let position = textField.position(from: textField.beginningOfDocument,
                                                 offset: offset) {
                textField.selectedTextRange = textField.textRange(from: position, to: position)
            }
            return false
        }
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

    static let iconColor = AppColor.Label.secondary
    static let iconFocusedColor = accentColor
    static let iconFont: Font = .system(size: AppToken.fieldIconSize,
                                        weight: AppToken.fieldIconWeight)
    static let iconMaxWidth = AppToken.fieldIconMaxWidth

    static let textColor = AppColor.Label.primary
    static let textFont: Font = .system(size: AppToken.fieldLabelSize,
                                        weight: AppToken.fieldLabelWeight,
                                        design: .monospaced)
    static let textUIFont: UIFont = .systemFont(ofSize: AppToken.fieldLabelSize,
                                                weight: .regular)

    static let hideShowButtonColor = AppColor.Label.secondary
    static let hideShowButtonFont: Font = .system(size: 15,
                                                  weight: .semibold)
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused

    @Previewable @State var text2 = ""

    VStack(spacing: 32) {
        Text("First text: \(text)")

        SecureInput("Eligendi Impedit",
                    text: $text,
                    icon: AppImage.Icon.edit.image,
                    isFocused: isFocused,
                    isValid: text.count == 8)
            .focused($isFocused)

        Text("Second text: \(text2)")

        SecureInput("Eligendi Impedit",
                    text: $text2,
                    isFocused: true,
                    isValid: text2.count == 8)
    }
    .padding()
    .background(AppColor.Scene.background)
}
