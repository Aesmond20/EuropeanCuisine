//
//  ReservationList.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 29/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct ReservationList: View {
    let workshops: [Workshop]
    let action: (UUID) -> Void

    var body: some View {
        List {
            ForEach(groupedWorkshops, id: \.date) { group in
                Section {
                    ForEach(group.items) { workshop in
                        Button(action: { action(workshop.id) }) {
                            WorkshopCell(workshop: workshop,
                                         isReserved: false)
                        }
                        .listRowSeparatorTint(Styles.separatorColor)
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    Text(group.date.formatted(date: .long, time: .omitted))
                        .font(Styles.labelFont)
                        .foregroundStyle(Styles.labelColor)
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
    static let labelFont: Font = .system(size: 20, weight: .bold)
    static let labelColor = AppColor.Label.title
}

#Preview {
    ReservationList(workshops: Workshop.examples,
                    action: { _ in })
}
