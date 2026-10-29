//
//  AuthAPIClient.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct AuthAPIClient {
    private let baseClient: BaseAPIClient

    init() {
        self.baseClient = .init()
    }

    func signUp(input: SignUpRequest) async throws -> SignUpResponse {
        try await request(path: "auth/sign-up",
                          method: .post,
                          body: baseClient.encoder.encode(input))
    }

    func logIn(input: LogInRequest) async throws -> TokenResponse {
        try await request(path: "auth/log-in",
                          method: .post,
                          body: baseClient.encoder.encode(input))
    }

    private func perform(path: String,
                         queryItems: [URLQueryItem] = [],
                         method: BaseAPIClient.HTTPMethod,
                         body: Data? = nil) async throws -> Data {
        try await baseClient.perform(path: path,
                                     queryItems: queryItems,
                                     method: method,
                                     body: body,
                                     invalidResponseError: AuthAPIClientError
                                         .invalidResponse,
                                     badStatusError: { AuthAPIClientError.badStatus($0, $1) })
    }

    private func request<T: Decodable>(path: String,
                                       queryItems: [URLQueryItem] = [],
                                       method: BaseAPIClient.HTTPMethod,
                                       body: Data? = nil) async throws -> T {
        try await baseClient.request(path: path,
                                     queryItems: queryItems,
                                     method: method,
                                     body: body,
                                     invalidResponseError: AuthAPIClientError.invalidResponse,
                                     badStatusError: { AuthAPIClientError.badStatus($0, $1) },
                                     decodingError: { AuthAPIClientError.decoding($0) })
    }
}
