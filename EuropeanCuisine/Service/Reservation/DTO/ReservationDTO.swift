//
//  ReservationDTO.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 29/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct ReservationInput: Encodable {
    let workshopID: UUID
}

struct ReservationResponse: Decodable, Identifiable {
    let id: UUID
    let status: String
    let workshop: WorkshopResponse
}

struct IsReservedResponse: Decodable {
    let isReserved: Bool
}

struct IsReservedListResponse: Decodable {
    let reservedWorkshopIDs: [UUID]
}
