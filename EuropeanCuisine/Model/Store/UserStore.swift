//
//  UserStore.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

@Observable
final class UserStore {
    var user: User?

    private let apiClient: UserAPIClient

    private let tokenKey = "user_token"
    private let account = "account"
    var token: String? {
        didSet {
            if let token {
                try? KeychainUtils.save(token,
                                        for: tokenKey,
                                        in: account)
            } else {
                try? KeychainUtils.delete(for: tokenKey,
                                          in: account)
            }
        }
    }

    init(token: String? = nil) {
        self.apiClient = .init()

        if let token {
            self.token = token
        } else {
            self.token = try? KeychainUtils.read(for: tokenKey,
                                                 in: account)
        }

        Task {
            await fetchUser()
        }
    }

    func fetchUser() async {
        guard let token,
              let userResponse = try? await apiClient.fetchOne(token: token) else {
            user = nil
            return
        }

        user = User(userResponse)
    }

    func addToken(_ newToken: String) {
        token = newToken

        Task {
            await fetchUser()
        }
    }

    func removeToken() {
        token = nil
        user = nil
    }
}
