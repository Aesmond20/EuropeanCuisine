//
//  ReservationAPIClient.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 17/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct ReservationAPIClient {
    private let baseClient: BaseAPIClient

    init() {
        self.baseClient = .init()
    }

    func fetchAll(token: String) async throws -> [ReservationResponse] {
        try await request(path: "reservations",
                          method: .get,
                          authenticationToken: token)
    }

    func create(workshopID: UUID,
                token: String) async throws -> ReservationResponse {
        let body = try baseClient.encoder.encode(ReservationInput(workshopID: workshopID))

        return try await request(path: "reservations",
                                 method: .post,
                                 body: body,
                                 authenticationToken: token)
    }

    func cancel(workshopID: UUID,
                token: String) async throws {
        _ = try await perform(path: "reservations/cancel",
                              queryItems: [URLQueryItem(name: "workshopID",
                                                        value: workshopID.uuidString)],
                              method: .patch,
                              authenticationToken: token)
    }

    func isReservedWorkshop(workshopID: UUID,
                            token: String) async throws -> IsReservedResponse {
        try await request(path: "reservations/is-reserved",
                          queryItems: [URLQueryItem(name: "workshopID",
                                                    value: workshopID.uuidString)],
                          method: .get,
                          authenticationToken: token)
    }

    func areReservedWorkshops(workshopIDs: [UUID],
                              token: String) async throws -> IsReservedListResponse {
        try await request(path: "reservations/are-reserved-list",
                          queryItems: [URLQueryItem(name: "workshopIDs",
                                                    value: workshopIDs.map(\.uuidString)
                                                        .joined(separator: ","))],
                          method: .get,
                          authenticationToken: token)
    }

    private func perform(path: String,
                         queryItems: [URLQueryItem] = [],
                         method: BaseAPIClient.HTTPMethod,
                         body: Data? = nil,
                         authenticationToken: String? = nil) async throws -> Data {
        try await baseClient.perform(path: path,
                                     queryItems: queryItems,
                                     method: method,
                                     body: body,
                                     authenticationToken: authenticationToken,
                                     invalidResponseError: ReservationAPIClientError
                                         .invalidResponse,
                                     badStatusError: {
                                         ReservationAPIClientError.badStatus($0, $1)
                                     })
    }

    private func request<T: Decodable>(path: String,
                                       queryItems: [URLQueryItem] = [],
                                       method: BaseAPIClient.HTTPMethod,
                                       body: Data? = nil,
                                       authenticationToken: String? = nil) async throws -> T {
        try await baseClient.request(path: path,
                                     queryItems: queryItems,
                                     method: method,
                                     body: body,
                                     authenticationToken: authenticationToken,
                                     invalidResponseError: ReservationAPIClientError
                                         .invalidResponse,
                                     badStatusError: {
                                         ReservationAPIClientError.badStatus($0, $1)
                                     },
                                     decodingError: {
                                         ReservationAPIClientError.decoding($0)
                                     })
    }
}
