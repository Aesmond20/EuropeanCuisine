//
//  WorkshopDetailScene.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 04/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct WorkshopDetailScene: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(ReservationStore.self) private var reservationStore

    let workshop: Workshop

    private var isReserved: Bool {
        reservationStore.isBooked(workshop)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppToken.Primitive.spacing5) {
                workshopImage

                VStack(alignment: .leading, spacing: AppToken.Primitive.spacing4) {
                    Text(workshop.name)
                        .font(Styles.titleFont)
                        .foregroundStyle(Styles.titleColor)

                    HStack(spacing: AppToken.Primitive.spacing2) {
                        Text(workshop.category)

                        Text("·")

                        Text(workshop.startTime,
                             format: .dateTime
                                 .weekday(.abbreviated)
                                 .day()
                                 .month(.abbreviated))

                        Text("·")

                        Text(workshop.startTime,
                             format: .dateTime
                                 .weekday(.abbreviated)
                                 .day()
                                 .month(.abbreviated))
                    }
                    .font(Styles.informationFont)
                    .foregroundStyle(Styles.informationColor)

                    Text(workshop.about)
                        .font(Styles.aboutFont)
                        .foregroundStyle(Styles.aboutColor)
                        .fixedSize(horizontal: false, vertical: true)

                    goodToKnow
                }
                .padding(.horizontal, AppToken.Primitive.padding4)
            }
            .padding(.bottom, AppToken.Primitive.padding8)
        }
        .background(Styles.background)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar(.hidden, for: .navigationBar)
        .safeAreaInset(edge: .top) {
            backButton
        }
        .safeAreaInset(edge: .bottom) {
            actionButton
        }
    }

    private var workshopImage: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: workshop.pictureURL)) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()

                default:
                    Image(systemName: "fork.knife")
                        .font(.system(size: 40, weight: .medium))
                        .foregroundStyle(Styles.placeholderForeground)
                        .frame(maxWidth: .infinity)
                        .frame(height: 280)
                        .background(Styles.placeholderBackground)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 280)
            .clipped()

            Image("workshop_wave")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .clipped()
        }
    }

    private var backButton: some View {
        HStack {
            Button("Back") {
                dismiss()
            }
            .buttonStyle(.orangeadeIconProminent(kind: .back,
                                                 icon: Image(systemName: "chevron.left")))

            Spacer()
        }
        .padding(.horizontal, AppToken.Primitive.padding4)
        .padding(.vertical, AppToken.Primitive.spacing3)
    }

    private var goodToKnow: some View {
        VStack(alignment: .leading, spacing: AppToken.Primitive.spacing3) {
            Text("Good to Know")
                .font(Styles.sectionTitleFont)
                .foregroundStyle(Styles.sectionTitleColor)

            if workshop.isVegan {
                goodToKnowRow(icon: "leaf.fill",
                              title: "Vegan friendly")
            }

            if workshop.isPRM {
                goodToKnowRow(icon: "figure.roll",
                              title: "Accessible to people with reduced mobility")
            }

            if workshop.isFamilyFriendly {
                goodToKnowRow(icon: "figure.2.and.child.holdinghands",
                              title: "Kids & family friendly")
            }
        }
    }

    private func goodToKnowRow(icon: String, title: String) -> some View {
        HStack(spacing: AppToken.Primitive.spacing3) {
            Image(systemName: icon)
                .font(Styles.goodToKnowIconFont)
                .foregroundStyle(Styles.goodToKnowIconColor)
                .frame(width: 24)

            Text(title)
                .font(Styles.goodToKnowFont)
                .foregroundStyle(Styles.goodToKnowColor)

            Spacer()
        }
    }

    private var actionButton: some View {
        Button(isReserved ? "Cancel" : "Book now") {
            if isReserved {
                reservationStore.cancel(workshop)
            } else {
                reservationStore.book(workshop)
            }
        }
        .disabled(!reservationStore.isLogIn)
        .buttonStyle(.orangeadeProminent(kind: isReserved ? .secondary : .primary,
                                         isFullWidth: true))
        .padding(.horizontal, AppToken.Primitive.padding4)
        .padding(.top, AppToken.Primitive.spacing3)
        .padding(.bottom, AppToken.Primitive.spacing2)
        .background(Styles.background)
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let titleFont = Font.dosis(size: 28,
                                      weight: .bold)

    static let sectionTitleFont = Font.dosis(size: 24,
                                             weight: .bold)

    static let titleColor = AppColor.Label.title
    static let sectionTitleColor = AppColor.Label.title

    static let informationFont = Font.system(size: 14,
                                             weight: .medium)

    static let informationColor = AppColor.Label.secondary

    static let aboutFont = Font.system(size: 16,
                                       weight: .regular)

    static let aboutColor = AppColor.Label.primary

    static let goodToKnowFont = Font.system(size: 15,
                                            weight: .regular)

    static let goodToKnowColor = AppColor.Label.primary

    static let goodToKnowIconFont = Font.system(size: 18,
                                                weight: .medium)

    static let goodToKnowIconColor = AppColor.accentPrimary

    static let placeholderForeground = AppColor.accentContrast
    static let placeholderBackground = AppColor.accentSecondary
}

#Preview {
    WorkshopDetailScene(workshop: WorkshopData.workshops[0])
        .environment(ReservationStore())
}
