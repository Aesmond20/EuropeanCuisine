//
//  Workshop.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 30/09/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct Workshop: Identifiable {
    let id: UUID
    let name: String
    let category: String
    let remainingCapacity: Int
    let maximumCapacity: Int
    let startTime: Date
    let endTime: Date
    let about: String
    let pictureURL: String
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool

    var bookedCapacity: Int {
        maximumCapacity - remainingCapacity
    }
}
