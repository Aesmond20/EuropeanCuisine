//
//  BoothCell.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothCell: View {
    let booth: Booth

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.horizontalSpacing) {
            thumbnailView

            labelsView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var labelsView: some View {
        VStack(alignment: .leading,
               spacing: Styles.verticalSpacing) {
            Text(booth.name)
                .font(Styles.titleFont)
                .foregroundStyle(Styles.titleColor)

            Text(subtitleString)
                .font(Styles.subtitleFont)
                .foregroundStyle(Styles.subtitleColor)
        }
    }

    private var subtitleString: String {
        booth.closingStatusText() ?? "No hours"
    }

    @ViewBuilder
    private var thumbnailView: some View {
        if let url = URL(string: booth.pictureURL) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: Styles.thumbnailSize,
                           height: Styles.thumbnailSize)
                    .clipShape(Styles.thumbnailShape)
                    .overlay {
                        Styles.thumbnailShape
                            .strokeBorder(Styles.borderColor,
                                          lineWidth: Styles.borderWidth)
                    }
            } placeholder: {
                thumbnailPlaceholder
            }
        } else {
            thumbnailPlaceholder
        }
    }

    private var thumbnailPlaceholder: some View {
        Styles.thumbnailShape
            .fill(Styles.placeholderThumbnailBackground)
            .frame(width: Styles.thumbnailSize,
                   height: Styles.thumbnailSize)
            .overlay {
                AppImage.Icon.boothThumbnailPlaceholder.image
                    .font(.system(size: Styles.thumbnailSize / 2.0))
                    .foregroundStyle(Styles.placeholderThumbnailForeground)
            }
    }
}

fileprivate enum Styles {
    static let verticalSpacing = AppToken.Primitive.spacing1
    static let horizontalSpacing = AppToken.Primitive.spacing3

    static let thumbnailSize: Double = 48
    static let cornerRadius = AppToken.Primitive.radiusXl
    static let thumbnailShape = RoundedRectangle(cornerRadius: cornerRadius)

    static let placeholderThumbnailForeground: Color = .init(uiColor: .darkGray)
    static let placeholderThumbnailBackground: Color = .init(uiColor: .lightGray)

    static let borderColor = AppColor.imageBorder
    static let borderWidth: Double = 1

    static let titleColor = AppColor.Label.primary
    static let titleFont: Font = .system(size: 17,
                                         weight: .bold)

    static let subtitleColor = AppColor.Label.secondary
    static let subtitleFont: Font = .system(size: 15,
                                            weight: .medium)
}

#Preview {
    BoothCell(booth: boothExample)
        .padding()
}

fileprivate let boothExample: Booth = .init(id: UUID(),
                                            name: "Caecati Inventore",
                                            description: "Magnam quis facere velit voluptate suscipit excepturi.",
                                            pictureURL: "https://picsum.photos/600/400",
                                            location: "Central 10",
                                            isVegan: true,
                                            isPRM: false,
                                            isFamilyFriendly: true,
                                            startTime: Date.hourMinute(hour: 10, minute: 30),
                                            endTime: Date.hourMinute(hour: 17, minute: 30),
                                            countryCode: "GBR",
                                            countryName: "Royaume-Uni")
