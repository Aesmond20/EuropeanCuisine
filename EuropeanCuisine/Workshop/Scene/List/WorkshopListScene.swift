//
//  WorkshopListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct WorkshopListScene: View {
    @State private var vm: WorkshopListViewModel

    @Environment(ReservationStore.self) private var reservationStore
    @Environment(UserStore.self) private var userStore

    init() {
        self._vm = State(initialValue: WorkshopListViewModel())
    }

    var body: some View {
        WorkshopList(workshops: vm.filteredWorkshops,
                     isReserved: reservationStore.isBooked,
                     action: vm.showBookDetail)
            .background(Styles.background)
            .sceneHeader("Workshop",
                         searchText: $vm.searchText,
                         searchPlaceholder: "Search a workshop",
                         topTrailingSplash: .init(version: .one,
                                                  kind: .quaternary)) {
                Menu {
                    Section("Seats") {
                        Toggle("Only available",
                               isOn: $vm.onlyAvailableSeats)
                    }

                    Section("Categories") {
                        ForEach(vm.categories, id: \.self) { category in
                            Toggle(category,
                                   isOn: categoryBinding(for: category))
                        }
                    }
                } label: {
                    Button("") {}
                        .buttonStyle(.orangeadeIconProminent(kind: .tertiary,
                                                             icon: AppImage.Icon.filter.image))
                }
            }
            .overlay {
                if vm.isLoading, vm.isWorkshopsEmpty {
                    ProgressView()
                }
            }
            .task {
                await reservationStore.fetchAll(token: userStore.token)
                await vm.fetchWorkshops()
            }
            .alert("Unable to load workshops",
                   isPresented: Binding(get: {
                                            vm.errorMessage != nil
                                        },
                                        set: { isPresented in
                                            if !isPresented {
                                                vm.clearError()
                                            }
                                        })) {
                Button("OK", role: .cancel) {
                    vm.clearError()
                }
            } message: {
                Text(vm.errorMessage ?? "An unexpected error occurred.")
            }
            .navigationDestination(item: $vm.selectedWorkshopID) { _ in
                if let workshop = vm.selectedWorkshop {
                    WorkshopDetailScene(workshop: workshop)
                }
            }
    }

    private func categoryBinding(for category: String) -> Binding<Bool> {
        Binding(get: {
                    vm.selectedCategories.contains(category)
                },
                set: { isSelected in
                    if isSelected {
                        vm.selectedCategories.insert(category)
                    } else {
                        vm.selectedCategories.remove(category)
                    }
                })
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
}

#Preview {
    NavigationStack {
        WorkshopListScene()
            .environment(ReservationStore())
            .environment(UserStore())
    }
}
