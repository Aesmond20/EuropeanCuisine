//
//  StringUtils.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 03/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

enum StringUtils {
    static func getUserInitials(for name: String) -> String? {
        let splitted = name.split(whereSeparator: \.isWhitespace).map(String.init)

        guard splitted.isNotEmpty else {
            return nil
        }

        if splitted.count == 1 {
            if let letters = splitted.first?.prefix(2) {
                return letters.capitalized
            } else {
                return nil
            }
        }

        return splitted
            .prefix(2)
            .map { $0.first ?? "-" }
            .map { $0.uppercased() }
            .joined(separator: "")
    }
}
