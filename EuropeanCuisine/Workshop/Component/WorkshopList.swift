////
////  WorkshopList.swift
////  EuropeanCuisine
////
////  Created by Aesmond on 16/10/2026.
////  Copyright © 2026 Aesmond. All rights reserved.
////
//
// import SwiftUI
//
// struct WorkshopList: View {
//    let workshops: [Workshop]
//    let action: (UUID) -> Void
//
//    @Environment(ReservationStore.self) private var reservationStore
//
//    @State private var searchText: String = ""
//    @State private var onlyAvailableSeats: Bool = false
//    @State private var selectedCategories: Set<String> = []
//
//    var body: some View {
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
//        .background(Styles.background)
//        .sceneHeader("Workshop",
//                     searchText: $searchText,
//                     searchPlaceholder: "Search a workshop",
//                     topTrailingSplash: .init(version: .one,
//                                              kind: .quaternary)) {
//            Menu {
//                Section("Seats") {
//                    Toggle("Only available",
//                           isOn: $onlyAvailableSeats)
//                }
//
//                Section("Categories") {
//                    ForEach(categories, id: \.self) { category in
//                        Toggle(category, isOn: Binding(get: {
//                            selectedCategories.contains(category)
//                        }, set: { _, _ in
//                            if selectedCategories.contains(category) {
//                                selectedCategories.remove(category)
//                            } else {
//                                selectedCategories.insert(category)
//                            }
//                        }))
//                    }
//                }
//            } label: {
//                Button("") {}
//                    .buttonStyle(.orangeadeIconProminent(kind: .tertiary,
//                                                         icon: AppImage.Icon.filter.image))
//            }
//        }
//    }
// }
//
// fileprivate enum Styles {
//    static let separatorColor = AppColor.Scene.divider
// }
//
// #Preview {
//    WorkshopList(workshops: Workshop.example, action: { _ in })
// }
