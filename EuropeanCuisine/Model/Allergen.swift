//
//  Allergen.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 12/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

enum Allergen: String, Codable, CaseIterable, Identifiable {
    case cerealsContainingGluten = "cereals_containing_gluten"
    case crustaceans
    case eggs
    case fish
    case peanuts
    case soybeans
    case milk
    case nuts
    case celery
    case mustard
    case sesameSeeds = "sesame_seeds"
    case sulphurDioxideAndSulphites = "sulphur_dioxide_and_sulphites"
    case lupin
    case molluscs

    var id: String {
        rawValue
    }

    var name: String {
        switch self {
        case .cerealsContainingGluten:
            String(localized: .allergenCerealsContainingGluten)
        case .crustaceans:
            String(localized: .allergenCrustaceans)
        case .eggs:
            String(localized: .allergenEggs)
        case .fish:
            String(localized: .allergenFish)
        case .peanuts:
            String(localized: .allergenPeanuts)
        case .soybeans:
            String(localized: .allergenSoybeans)
        case .milk:
            String(localized: .allergenMilk)
        case .nuts:
            String(localized: .allergenNuts)
        case .celery:
            String(localized: .allergenCelery)
        case .mustard:
            String(localized: .allergenMustard)
        case .sesameSeeds:
            String(localized: .allergenSesameSeeds)
        case .sulphurDioxideAndSulphites:
            String(localized: .allergenSulphurDioxideAndSulphites)
        case .lupin:
            String(localized: .allergenLupin)
        case .molluscs:
            String(localized: .allergenMolluscs)
        }
    }
}
