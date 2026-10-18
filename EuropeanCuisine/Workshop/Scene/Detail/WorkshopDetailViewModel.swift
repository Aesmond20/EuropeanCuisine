//
//  WorkshopDetailViewModel.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 17/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

@Observable
final class WorkshopDetailViewModel {
    private let client: WorkshopAPIClient
    private(set) var workshop: Workshop?

    init(id: UUID) {
        self.client = WorkshopAPIClient()
        self.workshop = nil

        fetchWorkshop(id: id)
    }

    private func fetchWorkshop(id: UUID) {
        Task {
            do {
                let response = try await client.fetchOne(id: id)
                workshop = Workshop(response)
            } catch {
                workshop = nil
            }
        }
    }
}
