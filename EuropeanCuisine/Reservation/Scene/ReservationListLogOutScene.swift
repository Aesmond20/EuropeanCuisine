//
//  ReservationListLogOutScene.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 04/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct ReservationListLogOutScene: View {
    var body: some View {
        VStack(spacing: AppToken.Primitive.spacing4) {
            Image(systemName: "person.crop.circle")
                .font(Styles.iconFont)
                .foregroundStyle(Styles.iconColor)

            VStack(spacing: AppToken.Primitive.spacing2) {
                Text("Not log in")
                    .font(Styles.titleFont)
                    .foregroundStyle(Styles.titleColor)

                Text("You cannot see your bookings because you are not logged in.")
                    .font(Styles.descriptionFont)
                    .foregroundStyle(Styles.descriptionColor)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, AppToken.Primitive.padding6)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Styles.background)
        .sceneHeader("Reservations")
    }
}

private enum Styles {
    static let background = AppColor.Scene.background

    static let iconFont = Font.system(size: 48, weight: .regular)
    static let iconColor = AppColor.accentSecondary

    static let titleFont = Font.dosis(size: 28,
                                      weight: .bold)

    static let titleColor = AppColor.Label.title

    static let descriptionFont = Font.system(size: 15,
                                             weight: .regular)

    static let descriptionColor = AppColor.Label.secondary
}

#Preview {
    ReservationListLogOutScene()
}
