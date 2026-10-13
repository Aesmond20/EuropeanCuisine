//
//  BoothResponse.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct BoothResponse: Decodable {
    let id: UUID
    let name: String
    let description: String
    let pictureURL: String
    let location: String
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool
    let allergens: Set<Allergen>
    let startTime: Date
    let endTime: Date
    let countryName: String
    let countryCode: String
}

extension Booth {
    init(_ booth: BoothResponse) {
        self.id = booth.id
        self.name = booth.name
        self.description = booth.description
        self.pictureURL = booth.pictureURL
        self.location = booth.location
        self.isVegan = booth.isVegan
        self.isPRM = booth.isPRM
        self.isFamilyFriendly = booth.isFamilyFriendly
        self.allergens = booth.allergens
        self.startTime = booth.startTime
        self.endTime = booth.endTime
        self.countryName = booth.countryName
        self.countryCode = booth.countryCode
    }
}
