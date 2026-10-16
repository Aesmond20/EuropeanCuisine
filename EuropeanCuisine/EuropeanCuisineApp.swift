//
//  EuropeanCuisineApp.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 22/09/2026.
//

import SwiftUI

@main
struct EuropeanCuisineApp: App {
    @State private var reservationStore: ReservationStore = .init()
    @State private var userStore: UserStore = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(reservationStore)
                .environment(userStore)
        }
    }
}
