//
//  ReservationListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ReservationListScene: View {
    @Environment(UserStore.self) private var userStore
    var body: some View {
        ReservationListSceneInternal(userStore: userStore)
    }
}

struct ReservationListSceneInternal: View {
    @State private var vm: ReservationListViewModel

    init(userStore: UserStore) {
        self._vm = State(initialValue: ReservationListViewModel(userStore: userStore))
    }

    var body: some View {
        ReservationList(workshops: vm.filteredReservedWorkshops,
                        action: vm.showWorkshopDetail)
            .background(Styles.background)
            .sceneHeader("Reservations",
                         searchText: $vm.searchText,
                         searchPlaceholder: "Search a reservation",
                         topTrailingSplash: .init(version: .one,
                                                  kind: .primary)) {
                Menu {
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
                await vm.fetchReservations()
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

private struct ReservationRow: View {
    let workshop: Workshop

    var body: some View {
        HStack(spacing: AppToken.Primitive.spacing3) {
            AsyncImage(url: URL(string: workshop.pictureURL)) { phase in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()

                default:
                    Image(systemName: "fork.knife")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Styles.placeholderForeground)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Styles.placeholderBackground)
                }
            }
            .frame(width: 32, height: 32)
            .clipShape(RoundedRectangle(cornerRadius: AppToken.Primitive.radiusMd))

            VStack(alignment: .leading, spacing: AppToken.Primitive.spacing5) {
                Text(workshop.name)
                    .font(Styles.nameFont)
                    .foregroundStyle(Styles.nameColor)
                    .lineLimit(1)

                Text(workshop.category)
                    .font(Styles.subtitleFont)
                    .foregroundStyle(Styles.subtitleColor)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)

            VStack(alignment: .trailing, spacing: AppToken.Primitive.spacing5) {
                AppImage.Icon.isBooked.image
                    .font(Styles.reservationIconFont)
                    .foregroundStyle(Styles.reservationIconColor)

                Text(workshop.startTime, format: .dateTime.hour().minute())
                    .font(Styles.timeFont)
                    .foregroundStyle(Styles.timeColor)
            }
        }
        .padding(.vertical, AppToken.Primitive.spacing1)
    }
}

private struct ReservationFilterView: View {
    @Binding var selectedCategory: String?

    private let categories = [
        "Recipe",
        "Fashion show",
        "Keynote",
        "Kids & family",
        "Discovery",
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: AppToken.Primitive.spacing4) {
            Text("Categories")
                .font(Styles.filterTitleFont)
                .foregroundStyle(Styles.filterTitleColor)

            ForEach(categories, id: \.self) { category in
                Button {
                    if selectedCategory == category {
                        selectedCategory = nil
                    } else {
                        selectedCategory = category
                    }
                } label: {
                    HStack {
                        Text(category)
                            .font(Styles.filterRowFont)
                            .foregroundStyle(Styles.filterRowColor)

                        Spacer()

                        if selectedCategory == category {
                            Image(systemName: "checkmark")
                                .font(Styles.checkmarkFont)
                                .foregroundStyle(Styles.checkmarkColor)
                        }
                    }
                    .contentShape(Rectangle())
                }
            }
        }
        .padding(AppToken.Primitive.padding4)
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

    static let reservationIconFont = Font.system(size: 12, weight: .semibold)
    static let reservationIconColor = AppColor.accentPrimary

    static let placeholderForeground = AppColor.accentContrast
    static let placeholderBackground = AppColor.accentSecondary

    static let filterTitleFont = Font.system(size: 17, weight: .semibold)
    static let filterRowFont = Font.system(size: 15, weight: .regular)

    static let filterTitleColor = AppColor.Label.title
    static let filterRowColor = AppColor.Label.primary
    static let checkmarkColor = AppColor.accentPrimary
    static let checkmarkFont = Font.system(size: 15, weight: .semibold)
}

#Preview {
    NavigationStack {
        ReservationListScene()
            .environment(UserStore())
    }
}
