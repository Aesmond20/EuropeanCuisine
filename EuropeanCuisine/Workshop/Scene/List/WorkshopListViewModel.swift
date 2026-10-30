//
//  WorkshopListViewModel.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

@Observable
final class WorkshopListViewModel {
    private let client: WorkshopAPIClient
    private let reservationClient: ReservationAPIClient
    private let userStore: UserStore

    private var sourceWorkshops: [WorkshopResponse]
    private var reservedWorkshopIDs: [UUID]

    var searchText: String
    var onlyAvailableSeats: Bool
    var selectedCategories: Set<String>
    var selectedWorkshopID: UUID?

    private(set) var isLoading: Bool
    private(set) var errorMessage: String?

    init(userStore: UserStore) {
        self.client = WorkshopAPIClient()
        self.reservationClient = ReservationAPIClient()
        self.userStore = userStore
        self.searchText = ""
        self.onlyAvailableSeats = false
        self.selectedCategories = []
        self.selectedWorkshopID = nil
        self.isLoading = false
        self.errorMessage = nil
        self.sourceWorkshops = []
        self.reservedWorkshopIDs = []
    }

    var isWorkshopsEmpty: Bool {
        sourceWorkshops.isEmpty
    }

    var isSearchEmpty: Bool {
        filteredWorkshops.isEmpty
    }

    var categories: [String] {
        Array(Set(sourceWorkshops.map(\.categoryName)))
            .sorted()
    }

    var filteredWorkshops: [Workshop] {
        sourceWorkshops
            .map(Workshop.init)
            .filter { workshop in
                let matchesSearch = searchText.trimmed.isEmpty
                    || workshop.name.localizedCaseInsensitiveContains(searchText.trimmed)

                let matchesSeats = !onlyAvailableSeats
                    || workshop.remainingCapacity > 0

                let matchesCategory = selectedCategories.isEmpty
                    || selectedCategories.contains(workshop.category)

                return matchesSearch
                    && matchesSeats
                    && matchesCategory
            }
            .sorted { $0.startTime < $1.startTime }
    }

    func fetchData() async {
        await sourceWorkshops = fetchWorkshops()
        await reservedWorkshopIDs = areReservedWorkshops(ids: sourceWorkshops.map(\.id))
    }

    func showBookDetail(id: UUID) {
        selectedWorkshopID = id
    }

    func clearError() {
        errorMessage = nil
    }

    func isReservedWorkshop(_ workshop: Workshop) -> Bool {
        reservedWorkshopIDs.contains(workshop.id)
    }

    private func fetchWorkshops() async -> [WorkshopResponse] {
        guard !isLoading else {
            return []
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            return try await client.fetchAll()
        } catch {
            errorMessage = error.localizedDescription
            return []
        }
    }

    private func areReservedWorkshops(ids: [UUID]) async -> [UUID] {
        guard let token = userStore.token else {
            return []
        }

        do {
            let response = try await reservationClient
                .areReservedWorkshops(workshopIDs: ids,
                                      token: token)

            return response.reservedWorkshopIDs
        } catch {
            return []
        }
    }
}
