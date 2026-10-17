//
//  WorkshopListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct WorkshopListScene: View {
    @State private var vm: WorkshopListViewModel = .init()

    @Environment(ReservationStore.self) private var reservationStore

    @State private var searchText: String = ""
    @State private var onlyAvailableSeats: Bool = false
    @State private var selectedCategories: Set<String> = []

    private var workshops: [Workshop] {
        WorkshopData.workshops.filter { workshop in
            let matchesSearch = searchText.isEmpty
                || workshop.name.localizedCaseInsensitiveContains(searchText)

            let allSeats = !onlyAvailableSeats
            let matchesSeats = allSeats
                || workshop.remainingCapacity > 0

            let matchesCategory = selectedCategories.isEmpty
                || selectedCategories.contains(workshop.category)

            return matchesSearch && matchesSeats && matchesCategory
        }
        .sorted { $0.startTime < $1.startTime }
    }

    var body: some View {
//        List {
//            ForEach(workshops) { workshop in
//                NavigationLink {
//                    WorkshopDetailScene(workshop: workshop)
//                        .orangeadeTabViewVisibility(.hidden)
//                } label: {
//                    WorkshopRow(workshop: workshop,
//                                isReserved: reservationStore.isBooked(workshop))
//                }
//                .listRowBackground(Color.clear)
//                .listRowSeparatorTint(Styles.listSeparator)
//            }
//        }
//        .listStyle(.plain)
        WorkshopList(workshops: vm.filteredWorkshops,
                     action: vm.showBookDetail)
            .background(Styles.background)
            .sceneHeader("Workshop",
                         searchText: $searchText,
                         searchPlaceholder: "Search a workshop",
                         topTrailingSplash: .init(version: .one,
                                                  kind: .quaternary)) {
                Menu {
                    Section("Seats") {
                        Toggle("Only available",
                               isOn: $onlyAvailableSeats)
                    }

                    Section("Categories") {
                        ForEach(categories, id: \.self) { category in
                            Toggle(category, isOn: Binding(get: {
                                selectedCategories.contains(category)
                            }, set: { _, _ in
                                if selectedCategories.contains(category) {
                                    selectedCategories.remove(category)
                                } else {
                                    selectedCategories.insert(category)
                                }
                            }))
                        }
                    }
                } label: {
                    Button("") {}
                        .buttonStyle(.orangeadeIconProminent(kind: .tertiary,
                                                             icon: AppImage.Icon.filter.image))
                }
            }
            .task {
                await vm.fetchWorkshops()
            }
            .navigationDestination(item: $vm.selectedWorkshopID) { id in
//                WorkshopDetailScene(id: id)
                Text("Workshop \(id)")
            }
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
    static let listSeparator = AppColor.Scene.divider

    static let nameFont = Font.system(size: 13, weight: .semibold)
    static let subtitleFont = Font.system(size: 10, weight: .regular)

    static let timeFont = Font.system(size: 10, weight: .regular)

    static let nameColor = AppColor.Label.title
    static let subtitleColor = AppColor.Label.secondary
    static let timeColor = AppColor.Label.primary
    static let secondaryTimeColor = AppColor.Label.secondary

    static let reservationIconFont = Font.system(size: 12, weight: .semibold)
    static let reservationIconColor = AppColor.accentPrimary

    static let placeholderForeground = AppColor.accentContrast
    static let placeholderBackground = AppColor.accentSecondary
}

#Preview {
    NavigationStack {
        WorkshopListScene()
            .environment(ReservationStore())
    }
}
