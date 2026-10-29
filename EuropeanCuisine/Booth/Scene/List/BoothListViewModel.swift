//
//  BoothListViewModel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 13/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class BoothListViewModel {
    private let client: BoothAPIClient

    var searchText: String
    private var sourceBooths: [BoothResponse]
    var selectedBoothID: UUID?

    init() {
        self.client = BoothAPIClient()
        self.searchText = ""
        self.sourceBooths = []
        self.selectedBoothID = nil
    }

    var isBooksEmpty: Bool {
        sourceBooths.isEmpty
    }

    var isSearchEmpty: Bool {
        filteredBooths.isEmpty
    }

    @MainActor
    var filteredBooths: [Booth] {
        guard searchText.isNotEmpty else {
            return sourceBooths.map(Booth.init)
        }

        return sourceBooths.filter { booth in
            let trimmed = searchText.trimmed

            return booth.name.localizedCaseInsensitiveContains(trimmed)
        }
        .map(Booth.init)
    }

    func fetchBooths() async {
        do {
            sourceBooths = try await client.fetchAll()
        } catch {
            sourceBooths = []
        }
    }

    func showBookDetail(id: UUID) {
        selectedBoothID = id
    }
}
