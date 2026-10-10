//
//  BoothListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothListScene: View {
    let booths: [Booth] = Booth.examples

    @State private var searchText: String = ""

    var body: some View {
        listView
            .overlay {
                if filteredBooths.isEmpty {
                    emptyListView
                }
            }
        .background(Styles.background)
        .sceneHeader(.boothsTitle,
                     searchText: $searchText,
                     searchPlaceholder: .boothsSearchFieldPlaceholder,
                     topTrailingSplash: .init(version: .one,
                                              kind: .tertiary))
    }

    private var listView: some View {
        BoothList(booths: filteredBooths)
    }

    private var emptyListView: some View {
        ContentUnavailableView(.boothsListEmptyTitle,
                               systemImage: AppImage.Icon.boothEmptyList.systemName)
    }

    private var filteredBooths: [Booth] {
        guard searchText.isNotEmpty else {
            return booths
        }

        return booths.filter { booth in
            let trimmed = searchText.trimmed

            return booth.name.localizedCaseInsensitiveContains(trimmed)
        }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
}

#Preview {
    BoothListScene()
}
