//
//  KeychainUtils.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

// source: https://mukeshydv.medium.com/securing-users-data-in-ios-with-swift-9e2be41c3b31

import Foundation

enum KeychainUtils {
    static func save(_ value: String, for key: String, in account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: value.data(using: .utf8)! as AnyObject,
        ]

        // Add a the new item to the keychain.
        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == noErr else {
            throw KeychainUtilsError.unexpectedStatus
        }
    }

    static func read(for key: String, in account: String) throws -> String {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: kCFBooleanTrue,
            kSecReturnData as String: kCFBooleanTrue,
        ]

        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else {
            throw KeychainUtilsError.unexpectedStatus
        }

        guard status == noErr else {
            throw KeychainUtilsError.unexpectedStatus
        }

        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8)
        else {
            throw KeychainUtilsError.parsing
        }

        return password
    }

    static func delete(for key: String, in account: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainUtilsError.unexpectedStatus
        }
    }
}

enum KeychainUtilsError: Error {
    case unexpectedStatus
    case parsing
}
