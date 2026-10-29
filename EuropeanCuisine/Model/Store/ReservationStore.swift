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
    var reservations: [ReservationResponse] = []

    private let apiClient: ReservationAPIClient

    init() {
        self.apiClient = .init()
    }

    func fetchAll(token: String?) async {
        guard let token else {
            reservations = []
            return
        }

        do {
            let response = try await apiClient.fetchAll(token: token)
            reservations = response

            for reservation in response {
                print("Réservation : \(reservation.id), statut : \(reservation.status)")
            }
        } catch {
            print(error)
            reservations = []
        }
    }

    func isBooked(_ workshop: Workshop) -> Bool {
        reservations.contains { reservation in
            reservation.workshop.id == workshop.id && reservation.status != "cancelled"
        }
    }

    func book(_ workshop: Workshop, token: String) async {
        guard let reservationResponse = try? await apiClient.create(workshopID: workshop.id,
                                                                    token: token) else {
            return
        }

        if reservations.firstIndex(where: {
            $0.id == reservationResponse.id
        }) != nil {
            reservations.append(reservationResponse)
        }
    }

    func cancel(_ workshop: Workshop, token: String) async {
        guard let reservation = reservations.first(where: {
            $0.workshop.id == workshop.id && $0.status != "cancelled"
        }) else {
            return
        }

        do {
            try await apiClient.cancel(id: reservation.id, token: token)

            reservations.removeAll {
                $0.id == reservation.id
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
