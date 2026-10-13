//
//  BoothAPIClient.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct BoothAPIClient {
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

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

    func fetchAll() async throws -> [BoothResponse] {
        try await request(path: "booths",
                          method: .get)
    }

    func fetchOne(id: UUID) async throws -> BoothResponse {
        try await request(path: "booths/\(id)",
                          method: .get)
    }

    private func perform(path: String, method: HTTPMethod, body: Data? = nil) async throws -> Data {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.value
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        if let body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = body
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let http = response as? HTTPURLResponse else {
            throw BoothAPIClientError.invalidResponse
        }

        guard (200 ..< 300).contains(http.statusCode) else {
            throw BoothAPIClientError.badStatus(http.statusCode)
        }
        return data
    }

    private func request<T: Decodable>(path: String, method: HTTPMethod,
                                       body: Data? = nil) async throws -> T {
        let data = try await perform(path: path, method: method, body: body)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw BoothAPIClientError.decoding(error)
        }
    }
}

extension BoothAPIClient {
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
