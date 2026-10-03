//
//  StringUtilsTest.swift
//  EuropeanCuisineTests
//
//  Created by Mathieu Nivelles on 03/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

@testable import EuropeanCuisine
import Testing

enum StringUtilsTest {
    @MainActor
    @Suite("#getUserInitials")
    struct GetUserInitials {
        @Test func `name with first name and last name is valid`() {
            let name = "Camille Durand"
            let expected = "CD"

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }

        @Test func `name with first name only is valid`() {
            let name = "Sasha"
            let expected = "Sa"

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }

        @Test func `name with one letter is valid`() {
            let name = "O"
            let expected = "O"

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }

        @Test func `lowercase first and last names are valid`() {
            let name = "nishima okito"
            let expected = "NO"

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }

        @Test func `empty name is not valid`() {
            let name = ""
            let expected: String? = nil

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }

        @Test func `name with spaces is not valid`() {
            let name = "   "
            let expected: String? = nil

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }

        @Test func `name with spaces and tabs is not valid`() {
            let name = "  \t  \t"
            let expected: String? = nil

            let result = StringUtils.getUserInitials(for: name)

            #expect(result == expected)
        }
    }
}
