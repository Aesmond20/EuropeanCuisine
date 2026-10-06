//
//  ReservationStore.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 04/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

@Observable
final class ReservationStore {
    var isLogIn: Bool = true
    private(set) var reservedWorkshopIDs: Set<UUID> = []

    init() {}

    func isBooked(_ workshop: Workshop) -> Bool {
        reservedWorkshopIDs.contains(workshop.id)
    }

    func book(_ workshop: Workshop) {
        guard isLogIn else {
            return
        }

        reservedWorkshopIDs.insert(workshop.id)
    }

    func cancel(_ workshop: Workshop) {
        reservedWorkshopIDs.remove(workshop.id)
    }
}
