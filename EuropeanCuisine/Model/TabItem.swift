//
//  TabItem.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

enum TabItem: String, Identifiable, CaseIterable {
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
            Image(systemName: "storefront")
        case .workshops:
            Image(systemName: "person.2.wave.2.fill")
        case .reservations:
            Image(systemName: "calendar.badge.checkmark")
        case .profile:
            Image(systemName: "person.crop.circle")
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
}
