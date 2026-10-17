//
//  WorkshopResponse.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct WorkshopResponse: Decodable {
    let id: UUID
    let name: String
    let startTime: Date
    let endTime: Date
    let capacityMax: UInt16
    let description: String
    let pictureURL: String
    let location: String
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool
    let categoryID: UUID
    let categoryName: String
}

extension Workshop {
    init(_ workshop: WorkshopResponse) {
        self.id = workshop.id
        self.name = workshop.name
        self.category = workshop.categoryName
        self.bookedCapacity = UInt16.random(in: 1 ... 10)
        self.maximumCapacity = workshop.capacityMax
        self.startTime = workshop.startTime
        self.endTime = workshop.endTime
        self.about = workshop.description
        self.pictureURL = workshop.pictureURL
        self.isVegan = workshop.isVegan
        self.isPRM = workshop.isPRM
        self.isFamilyFriendly = workshop.isFamilyFriendly
    }
}
