//
//  WorkshopDetailScene.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 04/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct WorkshopDetailScene: View {
    @Environment(UserStore.self) private var userStore

    private let id: UUID

    init(id: UUID) {
        self.id = id
    }

    var body: some View {
        WorkshopDetailSceneInternal(id: id, userStore: userStore)
    }
}

struct WorkshopDetailSceneInternal: View {
    @State private var vm: WorkshopDetailViewModel

    @Environment(\.dismiss) private var dismiss

    @State private var imageHeight: Double = 0
    @State private var scrollOffsetY: Double = 0
    @State private var scrollViewWidth: Double = 0

    init(id: UUID, userStore: UserStore) {
        self._vm = State(initialValue: WorkshopDetailViewModel(id: id, userStore: userStore))
    }

    var body: some View {
        Group {
            if let workshop = vm.workshop {
                contentView(workshop: workshop)
            } else {
                emptyView
            }
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            Button("") {
                dismiss()
            }
            .buttonStyle(.orangeadeIconProminent(kind: .back,
                                                 icon: Image(systemName: "arrow.left")))
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            actionButton
        }
        .orangeadeTabViewVisibility(.hidden)
    }

    private func contentView(workshop: Workshop) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppToken.Primitive.spacing5) {
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

                    Text(workshop.description)
                        .font(Styles.aboutFont)
                        .foregroundStyle(Styles.aboutColor)
                        .fixedSize(horizontal: false, vertical: true)

                    goodToKnow(workshop: workshop)
                }
                .padding(.horizontal, AppToken.Primitive.padding4)
            }
            .padding(.bottom, AppToken.Primitive.padding8)
            .padding(.top, imageHeight)
        }
        .background(alignment: .top) {
            AsyncImage(url: URL(string: workshop.pictureURL)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: imageHeight + max(scrollOffsetY, 0))
            .offset(y: min(0, scrollOffsetY))
            .clipped()
            .overlay(alignment: .bottom) {
                Image(.waveIcon)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Styles.background)
                    .offset(y: 1)
                    .frame(width: scrollViewWidth)
            }
        }
        .background(Styles.background)
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.contentOffset.y
        } action: { _, offsetY in
            scrollOffsetY = -offsetY
        }
        .onScrollGeometryChange(for: Double.self) { geo in
            geo.visibleRect.size.width
        } action: { _, visibleWidth in
            imageHeight = visibleWidth / Styles.imageRatio
            scrollViewWidth = visibleWidth
        }
        .ignoresSafeArea(.all, edges: .top)
    }

    private var emptyView: some View {
        ContentEmptyView("No Workshop found",
                         systemImage: AppImage.Icon.workshopNotFound.systemName)
    }

    private func goodToKnow(workshop: Workshop) -> some View {
        VStack(alignment: .leading, spacing: AppToken.Primitive.spacing3) {
            Text("Good to Know")
                .font(Styles.sectionTitleFont)
                .foregroundStyle(Styles.sectionTitleColor)

            if workshop.isVegan {
                GoodToKnowRow(icon: AppImage.Icon.isVegan.image,
                              label: "Vegan friendly")
            }

            if workshop.isPRM {
                GoodToKnowRow(icon: AppImage.Icon.isPRM.image,
                              label: "Accessible to people with reduced mobility")
            }

            if workshop.isFamilyFriendly {
                GoodToKnowRow(icon: AppImage.Icon.isFamilyFriendly.image,
                              label: "Kids & family friendly")
            }
        }
    }

    private var actionButton: some View {
        Button(vm.actionButtonLabel, role: vm.actionButtonRole) {}
            .buttonStyle(.orangeadeProminent(kind: vm.actionButtonKind, isFullWidth: true))
            .disabled(vm.actionButtonDisabled)
//        Button(isReserved ? "Cancel" : "Book now") {
//            Task {
//                guard let token = userStore.token else {
//                    return
//                }
//                if isReserved {
//                    await reservationStore.cancel(workshop, token: token)
//                } else {
//                    await reservationStore.book(workshop, token: token)
//                }
//            }
//        }
//        .disabled(userStore.user == nil)
//        .buttonStyle(.orangeadeProminent(kind: isReserved ? .secondary : .primary,
//                                         isFullWidth: true))
//        .padding(.horizontal, AppToken.Primitive.padding4)
//        .padding(.top, AppToken.Primitive.spacing3)
//        .padding(.bottom, AppToken.Primitive.spacing2)
//        .background(Styles.background)
    }
}

fileprivate struct GoodToKnowRow: View {
    let icon: Image
    let label: String

    var body: some View {
        HStack(spacing: AppToken.Primitive.spacing3) {
            icon
                .font(Styles.goodToKnowIconFont)
                .foregroundStyle(Styles.goodToKnowIconColor)
                .frame(width: 24)

            Text(label)
                .font(Styles.goodToKnowFont)
                .foregroundStyle(Styles.goodToKnowColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate enum Styles {
    static let imageRatio: Double = 6 / 5

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
    WorkshopDetailScene(id: UUID())
        .environment(ReservationStore())
        .environment(UserStore())
}
