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
                if booths.isEmpty {
                    emptyListView
                } else if filteredBooths.isEmpty {
                    emptySearchListView
                }
            }
            .background(Styles.background)
            .sceneHeader(.boothsTitle,
                         searchText: $searchText,
                         searchPlaceholder: .boothsSearchFieldPlaceholder,
                         topTrailingSplash: .init(version: .one,
                                                  kind: .tertiary))
    }

    private var emptyListView: some View {
        ContentEmptyView(.boothsListEmptyTitle,
                         systemImage: AppImage.Icon.boothEmptyList.systemName)
    }

    private var emptySearchListView: some View {
        ContentEmptyView.search(text: searchText)
    }

    private var listView: some View {
        BoothList(booths: filteredBooths)
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
