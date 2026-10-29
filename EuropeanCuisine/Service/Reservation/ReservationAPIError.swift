//
//  ReservationAPIError.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 17/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

enum ReservationAPIClientError: LocalizedError {
    case invalidResponse
    case badStatus(Int, String)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "The server returned an invalid response."
        case let .badStatus(status, reason):
            "E-\(status): \(reason)"
        case let .decoding(error):
            "Can't read data: \(error.localizedDescription)"
        }
    }
}
