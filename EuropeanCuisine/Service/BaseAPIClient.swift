//
//  BaseAPIClient.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct BaseAPIClient {
    private let baseURL: URL
    private let session: URLSession
    private(set) var decoder: JSONDecoder
    private(set) var encoder: JSONEncoder

    init() {
        self.baseURL = URL(string: "http://localhost:8080/api/v0")!
        self.session = URLSession.shared

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.encoder = encoder
    }

    func perform(path: String,
                 method: HTTPMethod,
                 body: Data? = nil,
                 authenticationToken token: String? = nil,
                 invalidResponseError: Error,
                 badStatusError: (Int, String) -> Error) async throws -> Data {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.value
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        if let body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = body
        }

        if let token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let http = response as? HTTPURLResponse else {
            throw invalidResponseError
        }

        guard (200 ..< 300).contains(http.statusCode) else {
            let reason = (try? JSONDecoder().decode(APIErrorResponse.self, from: data))?.reason
                ?? HTTPURLResponse.localizedString(forStatusCode: http.statusCode)
            throw badStatusError(http.statusCode, reason)
        }
        return data
    }

    func request<T: Decodable>(path: String,
                               method: HTTPMethod,
                               body: Data? = nil,
                               authenticationToken: String? = nil,
                               invalidResponseError: Error,
                               badStatusError: (Int, String) -> Error,
                               decodingError: (Error) -> Error) async throws -> T {
        let data = try await perform(path: path,
                                     method: method,
                                     body: body,
                                     authenticationToken: authenticationToken,
                                     invalidResponseError: invalidResponseError,
                                     badStatusError: badStatusError)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw decodingError(error)
        }
    }
}

extension BaseAPIClient {
    enum HTTPMethod: String {
        case get
        case post
        case put
        case patch
        case delete

        var value: String {
            switch self {
            case .get:
                "GET"
            case .post:
                "POST"
            case .put:
                "PUT"
            case .patch:
                "PATCH"
            case .delete:
                "DELETE"
            }
        }
    }
}
