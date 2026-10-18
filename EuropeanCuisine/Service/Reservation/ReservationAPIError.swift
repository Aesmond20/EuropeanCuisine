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
            "La réponse du serveur est invalide."

        case let .badStatus(status, reason):
            "Erreur API (\(status)) : \(reason)"

        case let .decoding(error):
            "Impossible de lire la réponse du serveur : \(error.localizedDescription)"
        }
    }
}
