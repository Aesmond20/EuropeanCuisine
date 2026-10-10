//
//  User.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 30/09/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct User {
    let id: UUID
    let name: String
    let email: String
    let pictureURL: String?
}

extension User {
    static let example: User = .init(id: UUID(),
                                     name: "Sasha Hamel",
                                     email: "sasha.hamel@amail.me",
                                     pictureURL: "https://picsum.photos/seed/hamel/1000/1000")
}
