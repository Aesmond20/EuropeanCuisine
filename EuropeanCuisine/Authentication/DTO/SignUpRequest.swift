//
//  SignUpRequest.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct SignUpRequest: Encodable {
    let name: String
    let email: String
    let password: String
}

struct SignUpResponse: Decodable {
    let id: UUID
    let name: String
    let email: String
    let pictureURL: String?
}
