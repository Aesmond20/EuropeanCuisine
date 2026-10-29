//
//  WorkshopListViewModel.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

@MainActor
@Observable
final class WorkshopListViewModel {
    private let client: WorkshopAPIClient

    private var sourceWorkshops: [WorkshopResponse]

    var searchText: String
    var onlyAvailableSeats: Bool
    var selectedCategories: Set<String>
    var selectedWorkshopID: UUID?

    private(set) var isLoading: Bool
    private(set) var errorMessage: String?

    init() {
        self.client = WorkshopAPIClient()
        self.sourceWorkshops = []
        self.searchText = ""
        self.onlyAvailableSeats = false
        self.selectedCategories = []
        self.selectedWorkshopID = nil
        self.isLoading = false
        self.errorMessage = nil
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

    func fetchWorkshops() async {
        guard !isLoading else {
            return
        }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            sourceWorkshops = try await client.fetchAll()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func showBookDetail(id: UUID) {
        selectedWorkshopID = id
    }

    func clearError() {
        errorMessage = nil
    }
}
