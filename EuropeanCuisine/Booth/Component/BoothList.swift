//
//  BoothList.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct BoothList: View {
    let booths: [Booth]
    let action: (UUID) -> Void

    var body: some View {
        List {
            ForEach(groupedBooths, id: \.country.code) { item in
                Section {
                    ForEach(item.list) { booth in
                        Button(action: { action(booth.id) }) {
                            BoothCell(booth: booth)
                        }
                        .listRowSeparatorTint(Styles.separatorColor)
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    ListSectionHeaderCountry(code: item.country.code,
                                             name: item.country.name)
                }
            }
        }
        .listStyle(.plain)
    }

    private var groupedBooths: [(country: (code: String, name: String), list: [Booth])] {
        let groupedByCountry = Dictionary(grouping: booths,
                                          by: { $0.countryCode })
        return groupedByCountry.map { item in
            let countryCode = item.key
            let countryName = item.value.first?.countryName ?? "N/A"
            let list = item.value
                .sorted(by: { first, second in
                    first.name.localizedCaseInsensitiveCompare(second.name) == .orderedAscending
                })

            return (country: (code: countryCode, name: countryName), list: list)
        }
        .sorted(by: { first, second in
            first.country.name
                .localizedCaseInsensitiveCompare(second.country.name) == .orderedAscending
        })
    }
}

fileprivate enum Styles {
    static let separatorColor = AppColor.Scene.divider
}

#Preview {
    BoothList(booths: Booth.examples, action: { _ in })
}
