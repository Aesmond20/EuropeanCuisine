//
//  UserAPIClient.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct UserAPIClient {
    private let baseClient: BaseAPIClient

    init() {
        self.baseClient = .init()
    }

    func fetchOne(token: String) async throws -> UserResponse {
        try await request(path: "users/infos",
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
                                     invalidResponseError: UserAPIClientError
                                         .invalidResponse,
                                     badStatusError: { UserAPIClientError.badStatus($0, $1) })
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
                                     invalidResponseError: UserAPIClientError.invalidResponse,
                                     badStatusError: { UserAPIClientError.badStatus($0, $1) },
                                     decodingError: { UserAPIClientError.decoding($0) })
    }
}
