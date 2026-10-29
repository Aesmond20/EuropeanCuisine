//
//  BoothDetailScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothDetailScene: View {
    @State private var vm: BoothDetailViewModel

    @State private var imageHeight: Double = 0
    @State private var scrollOffsetY: Double = 0
    @State private var scrollViewWidth: Double = 0

    @Environment(\.dismiss) private var dismiss

    init(id: UUID) {
        self._vm = State(initialValue: BoothDetailViewModel(id: id))
    }

    var body: some View {
        Group {
            if let booth = vm.booth {
                contentView(booth: booth)
            } else {
                emptyView
            }
        }
        .navigationBarBackButtonHidden(true)
        .orangeadeTabViewVisibility(.hidden)
        .overlay(alignment: .topLeading) {
            Button("") {
                dismiss()
            }
            .buttonStyle(.orangeadeIconProminent(kind: .back,
                                                 icon: AppImage.Icon.back.image))
            .padding(.horizontal)
        }
    }

    private func contentView(booth: Booth) -> some View {
        ScrollView {
            VStack(alignment: .leading,
                   spacing: Styles.verticalSpacing) {
                DetailHeader(title: booth.name,
                             subtitle: booth.countryName)

                VStack(alignment: .leading,
                       spacing: Styles.inlineInfosVerticalSpacing) {
                    DetailInlineInfo(icon: AppImage.Icon.boothLocation.image,
                                     label: booth.location)

                    DetailInlineInfo(icon: AppImage.Icon.eventDate.image,
                                     label: openingHours(startTime: booth.startTime,
                                                         endTime: booth.endTime))
                }

                DetailSectionParagraph(title: .boothDetailSectionAboutTitle,
                                       paragraph: booth.about)

                if booth.allergens.isNotEmpty {
                    BoothDetailAllergens(title: .boothDetailSectionAllergensTitle,
                                         allergens: booth.allergens,
                                         emptyMessage: .boothDetailSectionAllergensEmptyMessage)
                }

                if booth.isVegan || booth.isPRM || booth.isFamilyFriendly {
                    DetailGoodToKnow(title: .boothDetailSectionGoodToKnowTitle,
                                     isVegan: booth.isVegan,
                                     isPRM: booth.isPRM,
                                     isFamilyFriendly: booth.isFamilyFriendly)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, Styles.verticalPadding)
            .background(Styles.background)
            .padding(.top, imageHeight)
        }
        .background(alignment: .top) {
            AsyncImage(url: URL(string: booth.pictureURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: imageHeight + max(scrollOffsetY, 0))
            .offset(y: min(0, scrollOffsetY))
            .clipped()
            .overlay(alignment: .bottom) {
                AppImage.detailSceneWave
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
        ContentEmptyView(.boothDetailEmptyTitle,
                         systemImage: AppImage.Icon.boothNotFound.systemName)
            .background(Styles.background)
    }

    private func openingHours(startTime: Date, endTime: Date) -> String {
        let startTime = startTime.formatted(date: .omitted, time: .shortened)
        let endTnime = endTime.formatted(date: .omitted, time: .shortened)

        return "\(startTime) - \(endTime)"
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
    static let verticalSpacing = AppToken.Primitive.spacing6
    static let verticalPadding = AppToken.Primitive.padding4

    static let inlineInfosVerticalSpacing = AppToken.Primitive.spacing4

    static let imageRatio: Double = 6 / 5
}

#Preview {
    NavigationStack {
        BoothDetailScene(id: UUID())
    }
}
