////
////  WorkshopList.swift
////  EuropeanCuisine
////
////  Created by Aesmond on 16/10/2026.
////  Copyright © 2026 Aesmond. All rights reserved.
////

import SwiftUI

struct WorkshopList: View {
    let workshops: [Workshop]
    let isReserved: (Workshop) -> Bool
    let action: (UUID) -> Void

    var body: some View {
        List {
            ForEach(workshops) { workshop in
                Button(action: { action(workshop.id) }) {
                    WorkshopCell(workshop: workshop,
                                 isReserved: isReserved(workshop))
                }
                .listRowSeparatorTint(Styles.separatorColor)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
    static let separatorColor = AppColor.Scene.divider
}

#Preview {
    WorkshopList(workshops: [],
                 isReserved: { _ in true },
                 action: { _ in })
}
