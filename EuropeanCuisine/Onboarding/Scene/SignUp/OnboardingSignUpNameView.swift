//
//  OnboardingSignUpNameView.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 02/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingSignUpNameView: View {
    @Binding var name: String
    let nameErrorMessages: [String]

    @FocusState private var isNameFocused: Bool

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
        OnboardingFormHeader(title: .onboardingSignUpNameViewTitle,
                             subtitle: .onboardingSignUpNameViewSubtitle)
    }

    private var formView: some View {
        InputLabelWithContent(label: .onboardingFieldNameLabel,
                              errorMessages: nameErrorMessages) {
            TextInput(.onboardingFieldNamePlaceholder,
                      text: $name,
                      icon: AppImage.Icon.fieldName.image,
                      isFocused: isNameFocused)
                .focused($isNameFocused)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.words)
                .textContentType(.name)
        }
    }
}

fileprivate enum Styles {
    static let topPadding = AppToken.Primitive.padding2
    static let bottomPadding = AppToken.Primitive.padding6

    static let titleFormSpacing = AppToken.Primitive.spacing8
}

#Preview {
    @Previewable @State var name = ""

    OnboardingSignUpNameView(name: $name,
                             nameErrorMessages: [
                                 "Ipsum quas corrupti exercitationem.",
                                 "Officia consequatur dolorum et et est exercitationem et omnis.",
                             ])
}
