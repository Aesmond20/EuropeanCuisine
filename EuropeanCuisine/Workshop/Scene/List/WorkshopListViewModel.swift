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

    var searchText: String
    private var sourceWorkshops: [WorkshopResponse]
    var selectedWorkshopID: UUID?

    init() {
        self.client = WorkshopAPIClient()
        self.searchText = ""
        self.sourceWorkshops = []
        self.selectedWorkshopID = nil
    }

    var isBooksEmpty: Bool {
        sourceWorkshops.isEmpty
    }

    var isSearchEmpty: Bool {
        filteredWorkshops.isEmpty
    }

    @MainActor
    var filteredWorkshops: [Workshop] {
        guard searchText.isNotEmpty else {
            return sourceWorkshops.map(Workshop.init)
        }

        return sourceWorkshops.filter { workshop in
            let trimmed = searchText.trimmed

            return workshop.name.localizedCaseInsensitiveContains(trimmed)
        }
        .map(Workshop.init)
    }

    func fetchWorkshops() async {
        do {
            sourceWorkshops = try await client.fetchAll()
        } catch {
            sourceWorkshops = []

            print(error.localizedDescription)
        }
    }

    func showBookDetail(id: UUID) {
        selectedWorkshopID = id
    }
}
