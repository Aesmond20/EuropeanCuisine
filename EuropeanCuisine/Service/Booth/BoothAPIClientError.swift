//
//  BoothAPIClientError.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

enum BoothAPIClientError: LocalizedError {
    case invalidResponse
    case badStatus(Int, String)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "The server returned an invalid response."
        case let .badStatus(code, reason):
            "E-\(code): \(reason)"
        case let .decoding(error):
            "Can't read data: \(error.localizedDescription)"
        }
    }
}
