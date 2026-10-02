//
//  Constraints.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 02/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

enum Constraints {
    enum User {
        enum Email {}

        enum Name {
            static let length = 1 ... 100
        }

        enum Password {
            static let length = 12 ... 100
        }
    }

    static func isEmail(_ email: String) -> Bool {
        let regex = #/^[A-Za-z0-9._%+\-]+@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$/#

        let trimmedEmail = email.trimmed

        // RFC 5321
        guard email.trimmed.count <= 254 else {
            return false
        }

        guard trimmedEmail.wholeMatch(of: regex) != nil else {
            return false
        }

        return true
    }

    static func hasUppercaseLetter(_ text: String) -> Bool {
        text.contains { $0.isUppercase }
    }

    static func hasLowercaseLetter(_ text: String) -> Bool {
        text.contains { $0.isLowercase }
    }

    static func hasAtLeastOneNumber(_ text: String) -> Bool {
        text.contains { $0.isNumber }
    }

    static func hasAtLeastXcharacters(_ text: String, minLength: Int) -> Bool {
        text.count >= minLength
    }
}
