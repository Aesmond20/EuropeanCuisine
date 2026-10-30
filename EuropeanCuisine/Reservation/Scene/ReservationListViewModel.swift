//
//  ReservationListViewModel.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 29/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class ReservationListViewModel {
    private let client: ReservationAPIClient

    private var sourceReservations: [ReservationResponse]
    private var userStore: UserStore

    var searchText: String
    var selectedCategories: Set<String>
    var selectedWorkshopID: UUID?

    private(set) var isLoading: Bool
    private(set) var errorMessage: String?

    init(userStore: UserStore) {
        self.client = ReservationAPIClient()
        self.userStore = userStore
        self.sourceReservations = []
        self.searchText = ""
        self.selectedCategories = []
        self.selectedWorkshopID = nil
        self.isLoading = false
        self.errorMessage = nil
    }

    var isWorkshopsEmpty: Bool {
        sourceReservations.isEmpty
    }

    var isSearchEmpty: Bool {
        filteredReservedWorkshops.isEmpty
    }

    var categories: [String] {
        Array(Set(sourceReservations.map(\.workshop.categoryName)))
            .sorted()
    }

    var filteredReservedWorkshops: [Workshop] {
        sourceReservations.map { reservation in
            reservation.workshop
        }
        .map { workshop in
            Workshop(workshop)
        }
        .filter { workshop in
            let matchesSearch = searchText.trimmed.isEmpty
                ||
                workshop.name.localizedCaseInsensitiveContains(searchText.trimmed)

            let matchesCategory = selectedCategories.isEmpty
                || selectedCategories.contains(workshop.category)

            return matchesSearch
                && matchesCategory
        }
        .sorted { $0.startTime < $1.startTime }
    }

    func fetchReservations() async {
        guard !isLoading else {
            return
        }

        guard let token = userStore.token else {
            return
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            sourceReservations = try await client.fetchAll(token: token)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func showWorkshopDetail(id: UUID) {
        selectedWorkshopID = id
    }

    func clearError() {
        errorMessage = nil
    }
}
