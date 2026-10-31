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
                                                 icon: AppImage.Icon.back.image))
            .padding(.horizontal)
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

                    Text(workshop.category)
                        .font(Styles.subtitleFont)
                        .foregroundStyle(Styles.subtitleColor)

//                    HStack(spacing: AppToken.Primitive.spacing2) {
//                        Text("·")
//
//                        Text(workshop.startTime,
//                             format: .dateTime
//                                 .weekday(.abbreviated)
//                                 .day()
//                                 .month(.abbreviated))
//
//                        Text("·")
//
//                        Text(workshop.startTime,
//                             format: .dateTime
//                                 .weekday(.abbreviated)
//                                 .day()
//                                 .month(.abbreviated))
//                    }
//                    .font(Styles.informationFont)
//                    .foregroundStyle(Styles.informationColor)

                    VStack(alignment: .leading,
                           spacing: Styles.inlineInfosVerticalSpacing) {
                        DetailInlineInfo(icon: AppImage.Icon.remainingSeats.image,
                                         label: "\(workshop.remainingCapacity) seats left")

                        DetailInlineInfo(icon: AppImage.Icon.eventDate.image,
                                         label: dateAndTime(workshop: workshop))

                        DetailInlineInfo(icon: AppImage.Icon.workshopLocation.image,
                                         label: workshop.location)
                    }

                    DetailSectionParagraph(title: "About",
                                           paragraph: workshop.description)

                    DetailGoodToKnow(title: "Good to Know",
                                     isVegan: workshop.isVegan,
                                     isPRM: workshop.isPRM,
                                     isFamilyFriendly: workshop.isFamilyFriendly)
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
        .sceneFooter {
            actionButton
                .padding(.horizontal)
        }
    }

    private var emptyView: some View {
        ContentEmptyView("No Workshop found",
                         systemImage: AppImage.Icon.workshopNotFound.systemName)
            .background(Styles.background)
    }

    private var actionButton: some View {
        Button(vm.actionButtonLabel,
               role: vm.actionButtonRole,
               action: vm.performAction)
            .buttonStyle(.orangeadeProminent(kind: vm.actionButtonKind,
                                             icon: vm.actionButtonIcon,
                                             isFullWidth: true))
            .disabled(vm.actionButtonDisabled)
    }

    private func dateAndTime(workshop: Workshop) -> String {
        let dayFormat = Date.FormatStyle.dateTime
            .weekday(.wide)
            .month(.wide)
            .day()
            .locale(Locale(identifier: "en_US"))
        let day = workshop.startTime.formatted(dayFormat)

        var timeFormat = Date.FormatStyle(date: .omitted,
                                          time: .shortened,
                                          locale: Locale(identifier: "en_US"))
        timeFormat.timeZone = TimeZone(secondsFromGMT: 0)!
        let start = workshop.startTime.formatted(timeFormat)
        let end = workshop.endTime.formatted(timeFormat)
        return "\(day)\n\(start) - \(end)"
    }
}

fileprivate enum Styles {
    static let imageRatio: Double = 6 / 5

    static let background = AppColor.Scene.background

    static let titleFont = Font.dosis(size: 28,
                                      weight: .bold)
    static let titleColor = AppColor.Label.title

    static let subtitleFont: Font = .system(size: 17,
                                            weight: .medium)
    static let subtitleColor = AppColor.Label.primary

    static let informationFont = Font.system(size: 14,
                                             weight: .medium)

    static let informationColor = AppColor.Label.secondary

    static let inlineInfosVerticalSpacing = AppToken.Primitive.spacing4
}

#Preview {
    WorkshopDetailScene(id: UUID())
        .environment(UserStore())
}
