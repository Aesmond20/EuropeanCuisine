//
//  BoothListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothListScene: View {
    @State private var vm: BoothListViewModel = .init()

    var body: some View {
        listView
            .overlay {
                if vm.isBooksEmpty {
                    emptyListView
                } else if vm.isSearchEmpty {
                    emptySearchListView
                }
            }
            .background(Styles.background)
            .if(!vm.isBooksEmpty) {
                $0
                    .sceneHeader(.boothListTitle,
                                 searchText: $vm.searchText,
                                 searchPlaceholder: .boothListSearchFieldPlaceholder,
                                 topTrailingSplash: .init(version: .one,
                                                          kind: .tertiary))
            }
            .if(vm.isBooksEmpty) {
                $0
                    .sceneHeader(.boothListTitle,
                                 topTrailingSplash: .init(version: .one,
                                                          kind: .tertiary))
            }
            .task {
                await vm.fetchBooths()
            }
            .navigationDestination(item: $vm.selectedBoothID) { id in
                BoothDetailScene(id: id)
            }
    }

    private var emptyListView: some View {
        ContentEmptyView(.boothListListEmptyTitle,
                         systemImage: AppImage.Icon.boothEmptyList.systemName)
    }

    private var emptySearchListView: some View {
        ContentEmptyView.search(text: vm.searchText)
    }

    private var listView: some View {
        BoothList(booths: vm.filteredBooths,
                  action: vm.showBookDetail)
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
}

#Preview {
    NavigationStack {
        BoothListScene()
    }
}
