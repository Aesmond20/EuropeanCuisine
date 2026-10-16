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
        .padding(.top, Styles.topPadding)
        .padding(.bottom, Styles.bottomPadding)
    }

    private var headerView: some View {
        OnboardingFormHeader(title: .onboardingSignUpPasswordViewTitle,
                             subtitle: .onboardingSignUpPasswordViewSubtitle)
    }

    private var formView: some View {
        VStack(alignment: .leading,
               spacing: Styles.formVerticalSpacing) {
            passwordView

            confirmPasswordView

            passwordRulesView
        }
        .onSubmit {
            switch focusedField {
            case .password:
                focusedField = .confirmPassword
            case .confirmPassword:
                focusedField = nil
            case nil:
                break
            }
        }
    }

    private var passwordView: some View {
        InputLabelWithContent(label: .onboardingFieldPasswordLabel,
                              errorMessages: passwordErrorMessages) {
            SecureInput(.onboardingFieldPasswordPlaceholder,
                        text: $password,
                        icon: AppImage.Icon.fieldPassword.image,
                        isFocused: focusedField == .password,
                        isValid: isPasswordValid)
                .focused($focusedField, equals: .password)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .textContentType(.password)
                .submitLabel(.next)
        }
    }

    private var confirmPasswordView: some View {
        InputLabelWithContent(label: .onboardingFieldConfirmPasswordLabel) {
            SecureInput(.onboardingFieldConfirmPasswordPlaceholder,
                        text: $confirmPassword,
                        icon: AppImage.Icon.fieldPassword.image,
                        isFocused: focusedField == .confirmPassword,
                        isValid: isPasswordValid)
                .focused($focusedField, equals: .confirmPassword)
                .textContentType(.password)
                .submitLabel(.done)
        }
    }

    private var passwordRulesView: some View {
        VStack(alignment: .leading,
               spacing: Styles.rulesSpacing) {
            PasswordValidationRule(label: .onboardingFieldPasswordRuleUppercaseLetter,
                                   isValid: hasUppercaseLetter)

            PasswordValidationRule(label: .onboardingFieldPasswordRuleLowercaseLetter,
                                   isValid: hasLowercaseLetter)

            PasswordValidationRule(label: .onboardingFieldPasswordRuleOneNumber,
                                   isValid: hasAtLeastOneNumber)

            PasswordValidationRule(label: .onboardingFieldPasswordRuleMinCharacters(min: Constraints
                                       .User.Password.length.lowerBound),
            isValid: hasAtLeastXcharacters)

            PasswordValidationRule(label: .onboardingFieldPasswordRulePasswordMatch,
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

    init(label: String,
         isValid: Bool) {
        self.label = label
        self.isValid = isValid
    }

    init(label: LocalizedStringResource,
         isValid: Bool) {
        self.label = String(localized: label)
        self.isValid = isValid
    }

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
    static let topPadding = AppToken.Primitive.padding2
    static let bottomPadding = AppToken.Primitive.padding6

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
