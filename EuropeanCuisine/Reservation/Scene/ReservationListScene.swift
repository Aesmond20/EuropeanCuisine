//
//  ReservationListScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ReservationListScene: View {
    @Environment(ReservationStore.self) private var reservationStore
    @Environment(UserStore.self) private var userStore

    @State private var searchText: String = ""
    @State private var selectedCategories: Set<String> = []

    private var reservations: [Workshop] {
        reservationStore.reservations
            .filter { $0.status != "cancelled" }
            .map { Workshop($0.workshop) }
            .filter { workshop in
                let matchesSearch = searchText.isEmpty
                    || workshop.name.localizedCaseInsensitiveContains(searchText)

                let matchesCategory = selectedCategories.isEmpty
                    || selectedCategories.contains(workshop.category)

                return matchesSearch && matchesCategory
            }
            .sorted { $0.startTime < $1.startTime }
    }

    var body: some View {
        reservationList
    }

    private var reservationList: some View {
        List {
            if userStore.user != nil {
                ForEach(reservations) { workshop in
                    NavigationLink {
                        WorkshopDetailScene(workshop: workshop)
                            .orangeadeTabViewVisibility(.hidden)
                    } label: {
                        ReservationRow(workshop: workshop)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparatorTint(Styles.listSeparator)
                }
            }
        }
        .listStyle(.plain)
        .overlay {
            if userStore.user != nil {
                ContentEmptyView("Not log in",
                                 systemImage: AppImage.Icon.notLogIn.systemName,
                                 description: "You cannot see your bookings because you are not logged in.")
            }
        }
        .background(Styles.background)
        .if(userStore.user != nil) {
            $0
                .sceneHeader("Reservations",
                             searchText: $searchText,
                             searchPlaceholder: "Search a workshop",
                             topTrailingSplash: .init(version: .two,
                                                      kind: .primary)) {
                    Menu {
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
        }
        .if(userStore.user != nil) {
            $0
                .sceneHeader("Reservations",
                             topTrailingSplash: .init(version: .two,
                                                      kind: .primary))
        }

        .task(id: userStore.token) {
            guard let token = userStore.token else {
                return
            }

            await reservationStore.fetchAll(token: token)
        }
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
            .environment(ReservationStore())
            .environment(UserStore())
    }
}
