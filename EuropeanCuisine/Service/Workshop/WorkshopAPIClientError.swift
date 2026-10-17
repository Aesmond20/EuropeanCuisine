//
//  WorkshopAPIClientError.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

enum WorkshopAPIClientError: LocalizedError {
    case invalidResponse
    case badStatus(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "The server returned an invalid response."
        case let .badStatus(code):
            "The server responded with code \(code)."
        case let .decoding(error):
            "Can't read data: \(error.localizedDescription)"
        }
    }
}
