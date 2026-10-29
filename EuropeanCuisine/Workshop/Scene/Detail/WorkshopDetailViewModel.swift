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
    private let reservationClient: ReservationAPIClient
    private(set) var workshop: Workshop?
    private let userStore: UserStore
    private let workshopID: UUID

    var reservationState: ReservationState

    enum ReservationState {
        case notLogIn
        case reserved
        case notReserved
    }

    init(id: UUID, userStore: UserStore) {
        self.client = WorkshopAPIClient()
        self.reservationClient = ReservationAPIClient()
        self.workshop = nil
        self.userStore = userStore
        self.workshopID = id
        self.reservationState = .notLogIn

        Task {
            await fetchWorkshop()
            await setReservationState()
        }
    }

    var actionButtonLabel: String {
        switch reservationState {
        case .notLogIn:
            "Book now"
        case .reserved:
            "Cancel"
        case .notReserved:
            "Book now"
        }
    }

    var actionButtonDisabled: Bool {
        if reservationState == .notLogIn {
            return true
        }

        return false
    }

    var actionButtonKind: OrangeadeProminentButtonStyle.Kind {
        .secondary
    }

    var actionButtonRole: ButtonRole? {
        if reservationState == .reserved {
            return ButtonRole.destructive
        }
        return nil
    }

    private var isLogIn: Bool {
        userStore.hasToken
    }

    private func fetchWorkshop() async {
        do {
            let response = try await client.fetchOne(id: workshopID)
            workshop = Workshop(response)
        } catch {
            workshop = nil
        }
    }

    private func setReservationState() async {
        guard isLogIn else {
            reservationState = .notLogIn
            print("not log in")
            return
        }

        guard let token = userStore.token else {
            reservationState = .notLogIn
            print("no token")
            return
        }

        do {
            print("before response")
            let response = try await reservationClient
                .isReservedWorkshop(workshopID: workshopID,
                                    token: token)
            print("after response")
            reservationState = response.isReserved ? .reserved : .notReserved

        } catch {
            reservationState = .notLogIn
            print("error", error.localizedDescription)
        }
    }
}
