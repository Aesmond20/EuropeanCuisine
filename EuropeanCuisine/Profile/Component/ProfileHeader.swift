//
//  ProfileHeader.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 25/09/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct ProfileHeader: View {
    let pictureURL: String?
    let name: String
    let email: String

    var body: some View {
        VStack(spacing: Styles.contentSpacing) {
            if let pictureURL,
               let url = URL(string: pictureURL) {
                AsyncImage(url: url) { charge in
                    switch charge {
                    case .empty:
                        ProgressView()
                            .frame(width: Styles.pictureSize,
                                   height: Styles.pictureSize)
                    case let .success(image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: Styles.pictureSize,
                                   height: Styles.pictureSize)
                            .clipShape(Styles.pictureShape)
                            .overlay {
                                Styles.pictureShape
                                    .stroke(Styles.pictureBorder, lineWidth: Styles.pictureBorderWidth)
                            }
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }

        VStack {
            Text(name)
                .font(Styles.nameFont)
                .foregroundStyle(Styles.nameForeground)

            Text(email)
                .font(Styles.emailFont)
                .foregroundStyle(Styles.emailForeground)
        }
    }

    var placeholder: some View {
        Image(systemName: "person.fill")
            .font(Styles.placeholderIconFont)
            .foregroundStyle(Styles.placeholderForeground)
            .frame(width: Styles.pictureSize,
                   height: Styles.pictureSize)
            .background(Styles.placeholderBackground)
            .clipShape(Styles.pictureShape)
            .overlay {
                Styles.pictureShape
                    .stroke(Styles.pictureBorder, lineWidth: Styles.pictureBorderWidth)
            }
    }
}

fileprivate enum Styles {
    static let pictureSize: CGFloat = 128
    static let pictureShape = RoundedRectangle(cornerRadius: AppToken.Primitive.radiusFull)
    static let pictureBorder = AppColor.fieldBorder
    static let pictureBorderWidth = AppToken.fieldBorderWidth

    static let placeholderIconFont: Font = .system(size: 40,
                                                   weight: .medium,
                                                   design: .default)
    static let placeholderForeground = AppColor.accentContrast
    static let placeholderBackground = AppColor.accentSecondary

    static let contentSpacing = AppToken.Primitive.spacing2

    static let nameFont: Font = .system(size: 28,
                                        weight: .bold,
                                        design: .default)
    static let emailFont: Font = .system(size: 17,
                                         weight: .medium,
                                         design: .default)

    static let nameForeground = AppColor.Label.primary
    static let emailForeground = AppColor.Label.secondary
}

#Preview {
    ProfileHeader(pictureURL: "https://picsum.photos/1000/1000",
                  name: "Camille Dupont",
                  email: "camille.dupont@gmail.com")
}

#Preview("empty") {
    ProfileHeader(pictureURL: nil, name: "Camille", email: "camille@gmail.com")
}
