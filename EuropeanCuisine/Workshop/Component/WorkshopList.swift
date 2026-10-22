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
            ForEach(groupedWorkshops, id: \.date) { group in
                Section {
                    ForEach(group.items) { workshop in
                        Button(action: { action(workshop.id) }) {
                            WorkshopCell(workshop: workshop,
                                         isReserved: isReserved(workshop))
                        }
                        .listRowSeparatorTint(Styles.separatorColor)
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    Text(group.date.formatted(date: .long, time: .omitted))
                }
            }
        }
        .listStyle(.plain)
    }

    var groupedWorkshops: [(date: Date, items: [Workshop])] {
        let grouped = Dictionary(grouping: workshops) { workshop in
            workshop.startTime.formatted(date: .long, time: .omitted)
        }

        return grouped.map { _, value in
            let items = value.sorted(by: { $0.startTime < $1.startTime })
            let date = items.first?.startTime ?? .now

            return (date, items)
        }.sorted(by: { $0.date < $1.date })
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
    static let separatorColor = AppColor.Scene.divider
}

#Preview {
    WorkshopList(workshops: Workshop.examples,
                 isReserved: { _ in true },
                 action: { _ in })
}
