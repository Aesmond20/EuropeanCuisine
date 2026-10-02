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
        .padding(.vertical, Styles.verticalPadding)
    }

    private var headerView: some View {
        OnboardingHeader(title: "Let's start with your email",
                         subtitle: "We'll check if you already have an account. If not, we'll create a new one.")
    }

    private var formView: some View {
        InputLabelWithContent(label: "Email", errorMessages: emailErrorMessages) {
            TextInput("sasha@hamel.me",
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
    static let verticalPadding = AppToken.Primitive.padding6

    static let titleFormSpacing = AppToken.Primitive.spacing8
}

#Preview {
    @Previewable @State var email = ""

    OnboardingSignUpEmailView(email: $email,
                              emailErrorMessages: ["Officia quod voluptatem voluptatum."])
}
