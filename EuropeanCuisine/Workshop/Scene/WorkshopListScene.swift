//
//  WorkshopListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct WorkshopListScene: View {
    @State private var searchText: String = ""

    var body: some View {
        List {
            ForEach(0 ..< 40, id: \.self) { index in
                NavigationLink("Item \(index + 1)") {
                    Text("Item \(index + 1)")
                        .orangeadeTabViewVisibility(.hidden)
                }

                .listRowBackground(Color.clear)
                .listRowSeparatorTint(Styles.listSeparator)
            }
        }
        .listStyle(.plain)
        .background(Styles.background)
        .sceneHeader("Workshops",
                     searchText: $searchText,
                     searchPlaceholder: "Search a workshop") {
            Button("") {}
                .buttonStyle(.orangeadeIconProminent(kind: .tertiary,
                                                     icon: AppImage.Icon.filter.image))
        }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let listSeparator = AppColor.Scene.divider
}

#Preview {
    NavigationStack {
        WorkshopListScene()
    }
}
