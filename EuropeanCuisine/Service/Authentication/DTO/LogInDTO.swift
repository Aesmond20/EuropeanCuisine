//
//  LogInDTO.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct LogInRequest: Encodable {
    let email: String
    let password: String
}

struct TokenResponse: Decodable {
    let token: String
}
