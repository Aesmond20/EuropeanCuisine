//
//  BoothDetailViewModel.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 13/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class BoothDetailViewModel {
    private let client: BoothAPIClient
    private(set) var booth: Booth?

    init(id: UUID) {
        self.client = BoothAPIClient()
        self.booth = nil

        fetchBook(id: id)
    }

    private func fetchBook(id: UUID) {
        Task {
            do {
                let response = try await client.fetchOne(id: id)
                booth = Booth(response)
            } catch {
                booth = nil
            }
        }
    }
}
