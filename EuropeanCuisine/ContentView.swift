//
//  ContentView.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 22/09/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OrangeadeTabView(selection: 1) {
            OrangeadeTab(icon: AppTab.booths.icon,
                         name: AppTab.booths.name) {
                AppTab.booths.rootView
            }

            OrangeadeTab(icon: AppTab.workshops.icon,
                         name: AppTab.workshops.name) {
                WorkshopListScene()
            }

            OrangeadeTab(icon: AppTab.reservations.icon,
                         name: AppTab.reservations.name) {
                ReservationListScene()
            }

            OrangeadeTab(icon: AppTab.profile.icon,
                         name: AppTab.profile.name) {
                AppTab.profile.rootView
            }
        }
    }
}

#Preview {
    @Previewable @State var reservationStore = ReservationStore()

    ContentView()
        .environment(reservationStore)
}
