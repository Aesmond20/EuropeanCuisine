//
//  OnboardingSignUpEmailView.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 02/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingSignUpEmailView: View {
    @Binding var email: String
    let emailErrorMessages: [String]

    @FocusState private var isEmailFocused: Bool

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
        OnboardingFormHeader(title: .onboardingSignUpEmailViewTitle,
                             subtitle: .onboardingSignUpEmailViewSubtitle)
    }

    private var formView: some View {
        InputLabelWithContent(label: .onboardingFieldEmailLabel,
                              errorMessages: emailErrorMessages) {
            TextInput(.onboardingFieldEmailPlaceholder,
                      text: $email,
                      icon: AppImage.Icon.fieldEmail.image,
                      isFocused: isEmailFocused)
                .focused($isEmailFocused)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
        }
    }
}

fileprivate enum Styles {
    static let topPadding = AppToken.Primitive.padding2
    static let bottomPadding = AppToken.Primitive.padding6

    static let titleFormSpacing = AppToken.Primitive.spacing8
}

#Preview {
    @Previewable @State var email = ""

    OnboardingSignUpEmailView(email: $email,
                              emailErrorMessages: ["Officia quod voluptatem voluptatum."])
}
