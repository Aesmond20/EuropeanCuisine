//
//  WorkshopCell.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct WorkshopCell: View {
    let workshop: Workshop
    let isReserved: Bool

    var body: some View {
        HStack(alignment: .center, spacing: Styles.horizontalSpacing) {
            thumbnailView

            labelsView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var labelsView: some View {
        HStack {
            VStack(alignment: .leading, spacing: Styles.verticalSpacing) {
                Text(workshop.name)
                    .font(Styles.titleFont)
                    .foregroundStyle(Styles.titleColor)

                HStack(spacing: AppToken.Primitive.spacing2) {
                    Text(workshop.category)

                    Text("·")
                        .font(Styles.subtitleFont)

                    Text("\(workshop.bookedCapacity)/\(workshop.capacityMax)")
                }
                .font(Styles.subtitleFont)
                .foregroundStyle(Styles.subtitleColor)
                .lineLimit(1)
            }

            Spacer(minLength: 0)

            VStack(alignment: .trailing, spacing: Styles.verticalSpacing) {
                HStack(spacing: AppToken.Primitive.spacing2) {
                    if isReserved {
                        AppImage.Icon.isBooked.image
                            .font(Styles.reservationIconFont)
                            .foregroundStyle(Styles.reservationIconColor)
                    }

                    Text(workshop.startTime.formatted(timeFormat))
                        .font(Styles.timeFont)
                        .foregroundStyle(Styles.timeColor)
                }

                Text(workshop.endTime.formatted(timeFormat))
                    .font(Styles.timeFont)
                    .foregroundStyle(Styles.secondaryTimeColor)
            }
        }
    }

    private var timeFormat: Date.FormatStyle {
        Date.FormatStyle(date: .omitted,
                         time: .shortened,
                         locale: Locale(identifier: "en_US"),
                         timeZone: .gmt)
    }

    @ViewBuilder
    private var thumbnailView: some View {
        if let url = URL(string: workshop.pictureURL) {
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

    static let titleFont = Font.system(size: 17, weight: .bold)
    static let subtitleFont = Font.system(size: 15, weight: .medium)
    static let timeFont = Font.system(size: 15, weight: .medium)

    static let titleColor = AppColor.Label.primary
    static let subtitleColor = AppColor.Label.secondary
    static let timeColor = AppColor.Label.primary
    static let secondaryTimeColor = AppColor.Label.secondary

    static let reservationIconFont = Font.system(size: 15, weight: .semibold)
    static let reservationIconColor = AppColor.accentPrimary

    static let borderColor = AppColor.imageBorder
    static let borderWidth: Double = 1

    static let thumbnailSize: Double = 48
    static let cornerRadius = AppToken.Primitive.radiusXl
    static let thumbnailShape = RoundedRectangle(cornerRadius: cornerRadius)

    static let placeholderThumbnailForeground: Color = .init(uiColor: .darkGray)
    static let placeholderThumbnailBackground: Color = .init(uiColor: .lightGray)
}

#Preview {
    WorkshopCell(workshop: workshopExample, isReserved: true)
        .padding()
}

fileprivate let workshopExample: Workshop = .init(id: UUID(),
                                                  name: "French Pastry Masterclass",
                                                  category: "Recipe",
                                                  bookedCapacity: 7,
                                                  capacityMax: 13,
                                                  startTime: Date.hourMinute(hour: 10, minute: 0),
                                                  endTime: Date.hourMinute(hour: 15, minute: 0),
                                                  description: """
                                                  Discover the secrets of French pastry and learn how to prepare \
                                                  a delicate classic with a professional pastry chef.
                                                  """,
                                                  pictureURL: "https://picsum.photos/seed/french/600/400",
                                                  location: "Room 10C",
                                                  isVegan: false,
                                                  isPRM: true,
                                                  isFamilyFriendly: true)
