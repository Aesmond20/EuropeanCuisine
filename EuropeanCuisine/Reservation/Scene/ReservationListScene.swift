//
//  ReservationListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ReservationListScene: View {
    @State private var searchText: String = ""

    var body: some View {
        List {
            ForEach(0 ..< 40, id: \.self) {
                Text("Item \($0 + 1)")
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Styles.listSeparator)
            }
        }
        .listStyle(.plain)
        .background(Styles.background)
        .sceneHeader("Reservations",
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
    ReservationListScene()
}
