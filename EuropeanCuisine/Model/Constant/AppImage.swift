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
            }
        }

        var image: Image {
            Image(systemName: systemName)
        }
    }
}
