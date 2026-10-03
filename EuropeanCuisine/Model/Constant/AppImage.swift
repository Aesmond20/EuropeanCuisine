//
//  AppImage.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

enum AppImage {
    static let branchIcon: Image = .init(.branchIcon)
    static let onboardingAppName: Image = .init(.onboardingAppName)
    static let onboardingAppHero: Image = .init(.onboardingHero)

    enum Icon {
        case isBooked
        case book
        case unbook
        case edit
        case search
        case clearSearch
        case closeSearch
        case filter
        case showSecure
        case hideSecure
        case back
        case fieldName
        case fieldEmail
        case fieldPassword
        case passwordRuleIsValid
        case listDisclosure
        case logOut
        case legal
        case password
        case language
        case userPictureEmpty

        var systemName: String {
            switch self {
            case .isBooked:
                "bookmark.fill"
            case .book:
                "bookmark"
            case .unbook:
                "bookmark.slash.fill"
            case .edit:
                "square.and.pencil"
            case .search:
                "magnifyingglass"
            case .clearSearch:
                "xmark.circle.fill"
            case .closeSearch:
                "xmark"
            case .filter:
                "line.3.horizontal.decrease"
            case .showSecure:
                "eye"
            case .hideSecure:
                "eye.slash"
            case .back:
                "arrow.left"
            case .fieldName:
                "person"
            case .fieldEmail:
                "envelope"
            case .fieldPassword:
                "lock"
            case .passwordRuleIsValid:
                "checkmark"
            case .listDisclosure:
                "chevron.right"
            case .logOut:
                "rectangle.portrait.and.arrow.right"
            case .legal:
                "text.document"
            case .password:
                "lock"
            case .language:
                "globe"
            case .userPictureEmpty:
                "person.crop.circle.badge.questionmark.fill"
            }
        }

        var image: Image {
            Image(systemName: systemName)
        }
    }
}
