//
//  BoothAPIClient.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct BoothAPIClient {
    private let baseClient: BaseAPIClient

    init() {
        self.baseClient = .init()
    }

    func fetchAll() async throws -> [BoothResponse] {
        try await request(path: "booths",
                          method: .get)
    }

    func fetchOne(id: UUID) async throws -> BoothResponse {
        try await request(path: "booths/\(id)",
                          method: .get)
    }

    private func perform(path: String,
                         method: BaseAPIClient.HTTPMethod,
                         body: Data? = nil) async throws -> Data {
        try await baseClient.perform(path: path,
                                     method: method,
                                     body: body,
                                     invalidResponseError: BoothAPIClientError
                                         .invalidResponse,
                                     badStatusError: { BoothAPIClientError.badStatus($0) })
    }

    private func request<T: Decodable>(path: String,
                                       method: BaseAPIClient.HTTPMethod,
                                       body: Data? = nil) async throws -> T {
        try await baseClient.request(path: path,
                                     method: method,
                                     invalidResponseError: BoothAPIClientError.invalidResponse,
                                     badStatusError: { BoothAPIClientError.badStatus($0) },
                                     decodingError: { BoothAPIClientError.decoding($0) })
    }
}
