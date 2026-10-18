//
//  WorkshopAPIClient.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 16/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

struct WorkshopAPIClient {
    private let baseClient: BaseAPIClient

    init() {
        self.baseClient = .init()
    }

    func fetchAll() async throws -> [WorkshopResponse] {
        try await request(path: "workshops",
                          method: .get)
    }

    func fetchOne(id: UUID) async throws -> WorkshopResponse {
        try await request(path: "workshops/\(id)",
                          method: .get)
    }

    private func perform(path: String,
                         method: BaseAPIClient.HTTPMethod,
                         body: Data? = nil) async throws -> Data {
        try await baseClient.perform(path: path,
                                     method: method,
                                     body: body,
                                     invalidResponseError: WorkshopAPIClientError
                                         .invalidResponse,
                                     badStatusError: { WorkshopAPIClientError.badStatus($0, $1) })
    }

    private func request<T: Decodable>(path: String,
                                       method: BaseAPIClient.HTTPMethod,
                                       body: Data? = nil) async throws -> T {
        try await baseClient.request(path: path,
                                     method: method,
                                     invalidResponseError: WorkshopAPIClientError.invalidResponse,
                                     badStatusError: { WorkshopAPIClientError.badStatus($0, $1) },
                                     decodingError: { WorkshopAPIClientError.decoding($0) })
    }
}
