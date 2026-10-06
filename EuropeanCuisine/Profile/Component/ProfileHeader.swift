//
//  ProfileHeader.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 25/09/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct ProfileHeader: View {
    let name: String
    let email: String
    let pictureURL: String?

    var body: some View {
        VStack(spacing: Styles.verticalSpacing) {
            Group {
                if let pictureURL,
                   let url = URL(string: pictureURL) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            placeholder
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    placeholder
                }
            }
            .clipShape(Styles.pictureShape)
            .frame(width: Styles.pictureSize,
                   height: Styles.pictureSize)
            .padding(Styles.pictureBorderWidth * 2)
            .overlay {
                Styles.pictureShape
                    .strokeBorder(Styles.pictureBorder,
                                  lineWidth: Styles.pictureBorderWidth)
            }

            VStack(alignment: .center,
                   spacing: Styles.textVerticalSpacing) {
                Text(name)
                    .font(Styles.nameFont)
                    .foregroundStyle(Styles.nameForeground)

                Text(email)
                    .font(Styles.emailFont)
                    .foregroundStyle(Styles.emailForeground)
            }
        }
    }

    var placeholder: some View {
        Group {
            if let initials = StringUtils.getUserInitials(for: name) {
                Text(initials)
                    .font(Styles.placeholderFont)
            } else {
                Text("\(AppImage.Icon.userPictureEmpty.image)")
                    .font(Styles.placeholderIconFont)
            }
        }
        .minimumScaleFactor(Styles.placeholderMinimumScaleFactor)
        .foregroundStyle(Styles.placeholderForeground)
        .padding(.horizontal, Styles.placeholderHorizontalPadding)
        .frame(width: Styles.pictureSize,
               height: Styles.pictureSize)
        .background(Styles.placeholderBackground)
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing2

    static let pictureSize: Double = 128
    static let pictureShape = RoundedRectangle(cornerRadius: AppToken.Primitive.radiusFull)
    static let pictureBorder = AppColor.accentSecondary.opacity(0.4)
    static let pictureBorderWidth: Double = 4

    static let placeholderFont: Font = .system(size: 64,
                                               weight: .semibold,
                                               design: .rounded)
    static let placeholderIconFont: Font = .system(size: 64,
                                                   weight: .medium,
                                                   design: .rounded)
    static let placeholderMinimumScaleFactor: Double = 0.64
    static let placeholderHorizontalPadding = AppToken.Primitive.padding2
    static let placeholderForeground = AppColor.accentContrast
    static let placeholderBackground = AppColor.accentSecondary

    static let textVerticalSpacing = AppToken.Primitive.spacing05

    static let nameFont: Font = .system(size: 28,
                                        weight: .bold)
    static let nameForeground = AppColor.Label.primary

    static let emailFont: Font = .system(size: 17,
                                         weight: .medium)
    static let emailForeground = AppColor.Label.secondary
}

#Preview("with picture") {
    ProfileHeader(name: "Camille Durand",
                  email: "camille.dupont@gmail.com",
                  pictureURL: "https://picsum.photos/1000/1000")
}

#Preview("empty") {
    ProfileHeader(name: "Camille",
                  email: "camille@gmail.com",
                  pictureURL: nil)
}
