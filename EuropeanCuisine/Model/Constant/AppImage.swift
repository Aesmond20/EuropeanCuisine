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
    static let topTrailingSplashV1: Image = .init(.topTrailingSplashV1)
    static let topTrailingSplashV2: Image = .init(.topTrailingSplashV2)
    static let topTrailingSplashV3: Image = .init(.topTrailingSplashV3)
    static let detailSceneWave: Image = .init(.waveIcon)

    enum Icon {
        case tabBooths
        case tabWorkshops
        case tabReservations
        case tabProfile
        case boothThumbnailPlaceholder
        case boothEmptyList
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
        case remainingSeats
        case eventDate
        case boothLocation
        case isVegan
        case isPRM
        case isFamilyFriendly

        var systemName: String {
            switch self {
            case .tabBooths:
                "storefront"
            case .tabWorkshops:
                "person.2.wave.2.fill"
            case .tabReservations:
                "calendar.badge.checkmark"
            case .tabProfile:
                "person.crop.circle"
            case .boothThumbnailPlaceholder:
                "storefront.fill"
            case .boothEmptyList:
                "storefront"
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
            case .remainingSeats:
                "person.2"
            case .eventDate:
                "calendar.badge"
            case .boothLocation:
                "mappin.and.ellipse"
            case .isVegan:
                "leaf.fill"
            case .isPRM:
                "wheelchair"
            case .isFamilyFriendly:
                "figure.and.child.holdinghands"
            }
        }

        var image: Image {
            Image(systemName: systemName)
        }
    }
}
