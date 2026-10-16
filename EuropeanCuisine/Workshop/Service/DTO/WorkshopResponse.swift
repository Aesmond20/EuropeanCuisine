//
//  WorkshopResponse.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//  

//import Foundation
//
//struct WorkshopResponse: Decodable {
//    let id: UUID
//    let name: String
//    let category: String
//    let bookedCapacity: Int
//    let maximumCapacity: Int
//    let startTime: Date
//    let endTime: Date
//    let about: String
//    let pictureURL: String
//    let isVegan: Bool
//    let isPRM: Bool
//    let isFamilyFriendly: Bool
//    let categoryID: UUID
//    
//    var remainingCapacity: Int {
//        maximumCapacity - bookedCapacity
//    }
//}
//
//extension Workshop {
//    init(_ workshop: WorkshopResponse) {
//        self.id = workshop.id
//        self.name = workshop.name
//        self.about = workshop.about
//        self.maximumCapacity = Int(workshop.maximumCapacity)
//        self.pictureURL = workshop.pictureURL
//        self.isVegan = workshop.isVegan
//        self.isPRM = workshop.isPRM
//        self.isFamilyFriendly = workshop.isFamilyFriendly
//        self.startTime = workshop.startTime
//        self.endTime = workshop.endTime
//        self.category = workshop.category
//    }
//}
