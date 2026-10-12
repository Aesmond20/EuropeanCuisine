//
//  BoothDetailScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothDetailScene: View {
    let booth: Booth

    @State private var imageHeight: Double = 0
    @State private var scrollOffsetY: Double = 0
    @State private var scrollViewWidth: Double = 0

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading,
                   spacing: Styles.verticalSpacing) {
                DetailHeader(title: booth.name,
                             subtitle: booth.countryName)

                DetailInlineInfo(icon: AppImage.Icon.boothLocation.image,
                                 label: booth.location)

                DetailSectionParagraph(title: "About_PLC",
                                       paragraph: booth.description)

                if booth.isVegan || booth.isPRM || booth.isFamilyFriendly {
                    BoothDetailGoodToKnow(isVegan: booth.isVegan,
                                          isPRM: booth.isPRM,
                                          isFamilyFriendly: booth.isFamilyFriendly)
                }
            }
            .padding(.horizontal)
            .padding(.top, imageHeight)
            .padding(.vertical, Styles.verticalPadding)
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("") {
                    dismiss()
                }
                .buttonStyle(.orangeadeIconProminent(kind: .back,
                                                     icon: Image(systemName: "arrow.left")))
            }
        }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
    static let verticalSpacing = AppToken.Primitive.spacing6
    static let verticalPadding = AppToken.Primitive.padding4

    static let imageRatio: Double = 6 / 5
}

#Preview {
    BoothDetailScene(booth: Booth.examples.first!)
}
