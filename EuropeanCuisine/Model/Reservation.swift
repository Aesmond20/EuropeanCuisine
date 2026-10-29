//
//  Reservation.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 29/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct Reservation: Identifiable {
    let id: UUID
    let name: String
    let category: String
    let bookedCapacity: UInt16
    let capacityMax: UInt16
    let startTime: Date
    let endTime: Date
    let description: String
    let pictureURL: String
    let location: String
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool

    var remainingCapacity: UInt16 {
        guard bookedCapacity <= capacityMax else {
            return 999
        }

        return capacityMax - bookedCapacity
    }
}
