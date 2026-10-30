//
//  WorkshopListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct WorkshopListScene: View {
    @Environment(UserStore.self) private var userStore

    var body: some View {
        WorkshopListSceneInternal(userStore: userStore)
    }
}

struct WorkshopListSceneInternal: View {
    @State private var vm: WorkshopListViewModel

    init(userStore: UserStore) {
        self._vm = State(initialValue: WorkshopListViewModel(userStore: userStore))
    }

    var body: some View {
        WorkshopList(workshops: vm.filteredWorkshops,
                     isReserved: vm.isReservedWorkshop,
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
                await vm.fetchData()
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
            .navigationDestination(item: $vm.selectedWorkshopID) { id in
                WorkshopDetailScene(id: id)
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
            .environment(UserStore())
    }
}
