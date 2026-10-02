//
//  OnboardingSignUpPasswordView.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 02/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingSignUpPasswordView: View {
    @Binding var password: String
    @Binding var confirmPassword: String
    let passwordErrorMessages: [String]
    let hasUppercaseLetter: Bool
    let hasLowercaseLetter: Bool
    let hasAtLeastOneNumber: Bool
    let hasAtLeastXcharacters: Bool
    let hasPasswordMatch: Bool

    @FocusState private var focusedField: Field?

    enum Field {
        case password
        case confirmPassword
    }

    var body: some View {
        VStack(alignment: .leading,
               spacing: Styles.titleFormSpacing) {
            headerView

            formView
        }
        .padding(.horizontal)
        .padding(.vertical, Styles.verticalPadding)
    }

    private var headerView: some View {
        OnboardingHeader(title: "Create a password",
                         subtitle: "Add a way to protect your account.")
    }

    private var formView: some View {
        VStack(alignment: .leading,
               spacing: Styles.formVerticalSpacing) {
            passwordView

            confirmPasswordView

            passwordRulesView
        }
    }

    private var passwordView: some View {
        InputLabelWithContent(label: "Password",
                              errorMessages: passwordErrorMessages) {
            SecureInput("Password",
                        text: $password,
                        icon: AppImage.Icon.fieldPassword.image,
                        isFocused: focusedField == .password,
                        isValid: isPasswordValid)
                .focused($focusedField, equals: .password)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .textContentType(.password)
        }
    }

    private var confirmPasswordView: some View {
        InputLabelWithContent(label: "Confirm password") {
            SecureInput("Password",
                        text: $confirmPassword,
                        icon: AppImage.Icon.fieldPassword.image,
                        isFocused: focusedField == .confirmPassword,
                        isValid: isPasswordValid)
                .focused($focusedField, equals: .confirmPassword)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .textContentType(.password)
        }
    }

    private var passwordRulesView: some View {
        VStack(alignment: .leading,
               spacing: Styles.rulesSpacing) {
            PasswordValidationRule(label: "Uppercase letter",
                                   isValid: hasUppercaseLetter)

            PasswordValidationRule(label: "Lowercase letter",
                                   isValid: hasLowercaseLetter)

            PasswordValidationRule(label: "At least one number",
                                   isValid: hasAtLeastOneNumber)

            PasswordValidationRule(label: "At least \(Constraints.User.Password.length.lowerBound) characters",
                                   isValid: hasAtLeastXcharacters)

            PasswordValidationRule(label: "Passwords match",
                                   isValid: hasPasswordMatch)
        }
    }

    private var isPasswordValid: Bool {
        passwordErrorMessages.isEmpty
            && hasUppercaseLetter
            && hasLowercaseLetter
            && hasAtLeastOneNumber
            && hasAtLeastXcharacters
            && hasPasswordMatch
    }
}

fileprivate struct PasswordValidationRule: View {
    let label: String
    let isValid: Bool

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.iconRuleSpacing) {
            AppImage.Icon.passwordRuleIsValid.image
                .font(Styles.ruleIconFont)
                .foregroundStyle(isValid
                    ? Styles.ruleIsValidColor
                    : Styles.ruleIconIsInvalidColor)

            Text(label)
                .font(Styles.ruleFont)
                .foregroundStyle(isValid
                    ? Styles.ruleIsValidColor
                    : Styles.ruleIsInvalidColor)
        }
    }
}

fileprivate enum Styles {
    static let verticalPadding = AppToken.Primitive.padding6

    static let titleFormSpacing = AppToken.Primitive.spacing8
    static let formVerticalSpacing = AppToken.Primitive.spacing4

    static let rulesSpacing = AppToken.Primitive.spacing3
    static let iconRuleSpacing = AppToken.Primitive.spacing2

    static let ruleFont: Font = .system(size: 13,
                                        weight: .regular)
    static let ruleIsValidColor = AppColor.success
    static let ruleIsInvalidColor = AppColor.Label.primary

    static let ruleIconFont: Font = .system(size: 13,
                                            weight: .medium)
    static let ruleIconIsInvalidColor = AppColor.Label.secondary
}

#Preview {
    @Previewable @State var password = ""
    @Previewable @State var confirmPassword = ""

    OnboardingSignUpPasswordView(password: $password,
                                 confirmPassword: $confirmPassword,
                                 passwordErrorMessages: ["Sed animi a dolores voluptates est."],
                                 hasUppercaseLetter: true,
                                 hasLowercaseLetter: false,
                                 hasAtLeastOneNumber: true,
                                 hasAtLeastXcharacters: false,
                                 hasPasswordMatch: false)
}
