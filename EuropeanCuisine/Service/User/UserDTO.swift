//
//  UserDTO.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let id: UUID
    let name: String
    let email: String
    let pictureURL: String?
}

extension User {
    init(_ user: UserResponse) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.pictureURL = user.pictureURL
    }
}
