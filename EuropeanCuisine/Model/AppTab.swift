//
//  AppTab.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

enum AppTab: String, Identifiable {
    case booths
    case workshops
    case reservations
    case profile

    var id: String {
        rawValue
    }

    var icon: Image {
        switch self {
        case .booths:
            AppImage.Icon.tabBooths.image
        case .workshops:
            AppImage.Icon.tabWorkshops.image
        case .reservations:
            AppImage.Icon.tabReservations.image
        case .profile:
            AppImage.Icon.tabProfile.image
        }
    }

    var name: String {
        switch self {
        case .booths:
            String(localized: .tabBarItemBooths)
        case .workshops:
            String(localized: .tabBarItemWorkshops)
        case .reservations:
            String(localized: .tabBarItemReservations)
        case .profile:
            String(localized: .tabBarItemProfile)
        }
    }

    @ViewBuilder
    var rootView: some View {
        switch self {
        case .booths:
            BoothListScene()
        case .workshops:
            WorkshopListScene()
        case .reservations:
            ReservationListScene()
        case .profile:
            ProfileScene()
        }
    }
}
