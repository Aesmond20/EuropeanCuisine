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
            }
        }

        var image: Image {
            Image(systemName: systemName)
        }
    }
}
