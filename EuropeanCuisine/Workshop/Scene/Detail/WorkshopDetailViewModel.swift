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

    var actionButtonIcon: Image {
        switch reservationState {
        case .notLogIn:
            AppImage.Icon.book.image
        case .reserved:
            AppImage.Icon.unbook.image
        case .notReserved:
            AppImage.Icon.book.image
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

    func performAction() {
        switch reservationState {
        case .notLogIn:
            return
        case .reserved:
            cancelWorkshopReservation()
            return
        case .notReserved:
            reserveWorkshop()
        }
    }

    private func reserveWorkshop() {
        guard let token = userStore.token else {
            return
        }

        Task {
            do {
                let _ = try await reservationClient.create(workshopID: workshopID,
                                                           token: token)
                await setReservationState()
                await fetchWorkshop()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func cancelWorkshopReservation() {
        guard let token = userStore.token else {
            return
        }

        Task {
            do {
                try await reservationClient.cancel(workshopID: workshopID,
                                                   token: token)
                await setReservationState()
                await fetchWorkshop()
            } catch {
                print(error.localizedDescription)
            }
        }
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
            return
        }

        guard let token = userStore.token else {
            reservationState = .notLogIn
            return
        }

        do {
            let response = try await reservationClient
                .isReservedWorkshop(workshopID: workshopID,
                                    token: token)
            reservationState = response.isReserved ? .reserved : .notReserved

        } catch {
            reservationState = .notLogIn
        }
    }
}
