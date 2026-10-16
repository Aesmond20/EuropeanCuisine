//
//  Booth.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

struct Booth: Identifiable {
    let id: UUID
    let name: String
    let about: String
    let pictureURL: String
    let location: String
    let isVegan: Bool
    let isPRM: Bool
    let isFamilyFriendly: Bool
    let allergens: Set<Allergen>
    let startTime: Date
    let endTime: Date
    let countryCode: String
    let countryName: String

    func closingStatusText(now: Date = .now) -> String? {
        DateUtils.closingStatusText(startTime: startTime,
                                    endTime: endTime,
                                    now: now,
                                    closingSoonWindow: 60,
                                    recentlyClosedWindow: 30)
    }
}

extension Booth {
    static let examples: [Booth] = [
        // France
        Booth(id: UUID(),
              name: "Le Galetier",
              about: "Galettes de sarrasin bretonnes garnies (jambon-fromage-œuf, andouille) et crêpes au caramel au beurre salé.",
              pictureURL: "https://picsum.photos/seed/galetier/800",
              location: "Allée A - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk],
              startTime: Date.hourMinute(hour: 11, minute: 0),
              endTime: Date.hourMinute(hour: 17, minute: 0),
              countryCode: "FRA", countryName: "France"),
        Booth(id: UUID(),
              name: "Maison Savoyarde",
              about: "Tartiflette, croziflette et raclette au feu de bois avec fromages de Savoie.",
              pictureURL: "https://picsum.photos/seed/savoyarde/800",
              location: "Allée A - Stand 2",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.milk, .cerealsContainingGluten],
              startTime: Date.hourMinute(hour: 12, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "FRA", countryName: "France"),
        Booth(id: UUID(),
              name: "Éclair d'Or",
              about: "Éclairs, macarons et religieuses préparés par un artisan pâtissier parisien.",
              pictureURL: "https://picsum.photos/seed/eclair/800",
              location: "Allée A - Stand 3",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk, .nuts],
              startTime: Date.hourMinute(hour: 9, minute: 0),
              endTime: Date.hourMinute(hour: 16, minute: 30),
              countryCode: "FRA", countryName: "France"),

        // Croatie
        Booth(id: UUID(),
              name: "Štrukli Zagreb",
              about: "Štrukli croates à la pâte fine et au fromage frais, servis cuits au four avec de la crème, ou bouillis.",
              pictureURL: "https://picsum.photos/seed/strukli/800",
              location: "Allée J - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk],
              startTime: Date.hourMinute(hour: 10, minute: 30),
              endTime: Date.hourMinute(hour: 17, minute: 30),
              countryCode: "HRV", countryName: "Croatie"),
        Booth(id: UUID(),
              name: "Fritule Dalmatia",
              about: "Petits beignets dalmates parfumés au zeste d'agrumes et au rhum, saupoudrés de sucre glace.",
              pictureURL: "https://picsum.photos/seed/fritule/800",
              location: "Allée J - Stand 2",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk],
              startTime: Date.hourMinute(hour: 11, minute: 0),
              endTime: Date.hourMinute(hour: 16, minute: 0),
              countryCode: "HRV", countryName: "Croatie"),

        // Chypre
        Booth(id: UUID(),
              name: "Halloumi & Sheftalia Larnaka",
              about: "Halloumi grillé, sheftalia (saucisses chypriotes), pita, tomates et menthe fraîche.",
              pictureURL: "https://picsum.photos/seed/halloumi/800",
              location: "Allée J - Stand 3",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.milk, .cerealsContainingGluten, .sesameSeeds],
              startTime: Date.hourMinute(hour: 12, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "CYP", countryName: "Chypre"),

        // Espagne
        Booth(id: UUID(),
              name: "Tapas y Más",
              about: "Assortiment de tapas : patatas bravas, croquetas, tortilla et jamón ibérico.",
              pictureURL: "https://picsum.photos/seed/tapas/800",
              location: "Allée C - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: false,
              allergens: [.cerealsContainingGluten, .eggs, .milk, .sulphurDioxideAndSulphites],
              startTime: Date.hourMinute(hour: 13, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "ESP", countryName: "Espagne"),
        Booth(id: UUID(),
              name: "Churros de Madrid",
              about: "Churros frits minute servis avec chocolat chaud épais ou sucre-cannelle.",
              pictureURL: "https://picsum.photos/seed/churros/800",
              location: "Allée C - Stand 2",
              isVegan: true, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten],
              startTime: Date.hourMinute(hour: 8, minute: 30),
              endTime: Date.hourMinute(hour: 15, minute: 0),
              countryCode: "ESP", countryName: "Espagne"),
        Booth(id: UUID(),
              name: "Paella Valenciana",
              about: "Paella cuite dans une poêle géante au feu de bois : poulet-lapin ou fruits de mer.",
              pictureURL: "https://picsum.photos/seed/paella/800",
              location: "Allée C - Stand 3",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.crustaceans, .molluscs, .fish, .celery, .sulphurDioxideAndSulphites],
              startTime: Date.hourMinute(hour: 11, minute: 30),
              endTime: Date.hourMinute(hour: 17, minute: 30),
              countryCode: "ESP", countryName: "Espagne"),

        // Allemagne
        Booth(id: UUID(),
              name: "Bratwurst & Brezel",
              about: "Saucisses grillées de Nuremberg, bretzels tout juste sortis du four et choucroute.",
              pictureURL: "https://picsum.photos/seed/bratwurst/800",
              location: "Allée D - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .mustard, .celery, .sulphurDioxideAndSulphites],
              startTime: Date.hourMinute(hour: 10, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "DEU", countryName: "Allemagne"),
        Booth(id: UUID(),
              name: "Kartoffelpuffer Express",
              about: "Galettes de pommes de terre croustillantes avec compote de pommes ou saumon fumé.",
              pictureURL: "https://picsum.photos/seed/kartoffelpuffer/800",
              location: "Allée D - Stand 2",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.eggs, .cerealsContainingGluten, .fish],
              startTime: Date.hourMinute(hour: 11, minute: 0),
              endTime: Date.hourMinute(hour: 16, minute: 30),
              countryCode: "DEU", countryName: "Allemagne"),

        // Grèce
        Booth(id: UUID(),
              name: "Souvlaki Athína",
              about: "Brochettes de porc ou de poulet, pita, tzatziki, tomates et oignons rouges.",
              pictureURL: "https://picsum.photos/seed/souvlaki/800",
              location: "Allée E - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .milk, .sesameSeeds],
              startTime: Date.hourMinute(hour: 12, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "GRC", countryName: "Grèce"),
        Booth(id: UUID(),
              name: "Mezedes d'Ikaria",
              about: "Mezzés végétaux : dolmadès, gigantes, fava de Santorin, houmous et salade grecque sans feta.",
              pictureURL: "https://picsum.photos/seed/mezedes/800",
              location: "Allée E - Stand 2",
              isVegan: true, isPRM: true, isFamilyFriendly: true,
              allergens: [.sesameSeeds, .celery, .sulphurDioxideAndSulphites],
              startTime: Date.hourMinute(hour: 10, minute: 0),
              endTime: Date.hourMinute(hour: 17, minute: 0),
              countryCode: "GRC", countryName: "Grèce"),

        // Pologne
        Booth(id: UUID(),
              name: "Pierogi Babcia",
              about: "Raviolis polonais faits maison : viande, chou et champignons, pommes de terre et fromage blanc.",
              pictureURL: "https://picsum.photos/seed/pierogi/800",
              location: "Allée F - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk, .celery],
              startTime: Date.hourMinute(hour: 11, minute: 0),
              endTime: Date.hourMinute(hour: 17, minute: 30),
              countryCode: "POL", countryName: "Pologne"),
        Booth(id: UUID(),
              name: "Zapiekanka Kraków",
              about: "Baguette gratinée de Cracovie aux champignons, fromage fondu et ketchup.",
              pictureURL: "https://picsum.photos/seed/zapiekanka/800",
              location: "Allée F - Stand 2",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .milk],
              startTime: Date.hourMinute(hour: 12, minute: 30),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "POL", countryName: "Pologne"),

        // Portugal
        Booth(id: UUID(),
              name: "Pastéis de Nata Lisboa",
              about: "Pastéis de nata chauds à la cannelle, accompagnés d'un café bica.",
              pictureURL: "https://picsum.photos/seed/pasteis/800",
              location: "Allée G - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk],
              startTime: Date.hourMinute(hour: 8, minute: 0),
              endTime: Date.hourMinute(hour: 15, minute: 0),
              countryCode: "PRT", countryName: "Portugal"),

        // Belgique
        Booth(id: UUID(),
              name: "Frites de Bruxelles",
              about: "Frites belges double cuisson, cuites à l'huile végétale, avec une dizaine de sauces maison.",
              pictureURL: "https://picsum.photos/seed/frites/800",
              location: "Allée G - Stand 2",
              isVegan: true, isPRM: true, isFamilyFriendly: true,
              allergens: [.mustard],
              startTime: Date.hourMinute(hour: 11, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "BEL", countryName: "Belgique"),
        Booth(id: UUID(),
              name: "Gaufres de Liège",
              about: "Gaufres liégeoises au sucre perlé, nappées de chocolat belge, fruits rouges ou crème.",
              pictureURL: "https://picsum.photos/seed/gaufres/800",
              location: "Allée G - Stand 3",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk, .soybeans],
              startTime: Date.hourMinute(hour: 9, minute: 30),
              endTime: Date.hourMinute(hour: 16, minute: 0),
              countryCode: "BEL", countryName: "Belgique"),

        // Suisse
        Booth(id: UUID(),
              name: "Raclette du Valais",
              about: "Raclette au fromage AOP du Valais, pommes de terre en robe des champs, cornichons et oignons.",
              pictureURL: "https://picsum.photos/seed/raclette/800",
              location: "Allée H - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.milk],
              startTime: Date.hourMinute(hour: 12, minute: 0),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "CHE", countryName: "Suisse"),
        Booth(id: UUID(),
              name: "Rösti & Älplermagronen",
              about: "Rösti croustillants et macaronis des alpages aux pommes de terre, oignons et compote de pommes.",
              pictureURL: "https://picsum.photos/seed/rosti/800",
              location: "Allée H - Stand 2",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .milk],
              startTime: Date.hourMinute(hour: 11, minute: 0),
              endTime: Date.hourMinute(hour: 17, minute: 0),
              countryCode: "CHE", countryName: "Suisse"),

        // Pays-Bas
        Booth(id: UUID(),
              name: "Stroopwafels & Poffertjes",
              about: "Stroopwafels chaudes au caramel et mini-pancakes poffertjes au beurre et sucre glace.",
              pictureURL: "https://picsum.photos/seed/stroopwafel/800",
              location: "Allée I - Stand 1",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk],
              startTime: Date.hourMinute(hour: 10, minute: 0),
              endTime: Date.hourMinute(hour: 16, minute: 0),
              countryCode: "NLD", countryName: "Pays-Bas"),

        // Hongrie
        Booth(id: UUID(),
              name: "Lángos Budapest",
              about: "Beignets salés hongrois à la crème aigre, à l'ail et au fromage râpé, ou sucrés.",
              pictureURL: "https://picsum.photos/seed/langos/800",
              location: "Allée I - Stand 2",
              isVegan: false, isPRM: false, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .milk],
              startTime: Date.hourMinute(hour: 12, minute: 0),
              endTime: Date.hourMinute(hour: 17, minute: 30),
              countryCode: "HUN", countryName: "Hongrie"),

        // Suède
        Booth(id: UUID(),
              name: "Köttbullar & Kanelbullar",
              about: "Boulettes de viande suédoises, sauce à la crème, confiture d'airelles et brioches à la cannelle.",
              pictureURL: "https://picsum.photos/seed/kottbullar/800",
              location: "Allée I - Stand 3",
              isVegan: false, isPRM: true, isFamilyFriendly: true,
              allergens: [.cerealsContainingGluten, .eggs, .milk],
              startTime: Date.hourMinute(hour: 11, minute: 30),
              endTime: Date.hourMinute(hour: 17, minute: 0),
              countryCode: "SWE", countryName: "Suède"),

        // Autriche
        Booth(id: UUID(),
              name: "Wiener Schnitzel Haus",
              about: "Escalopes viennoises panées à la minute, salade de pommes de terre et citron.",
              pictureURL: "https://picsum.photos/seed/wiener/800",
              location: "Allée D - Stand 3",
              isVegan: false, isPRM: true, isFamilyFriendly: false,
              allergens: [.cerealsContainingGluten, .eggs, .milk, .mustard],
              startTime: Date.hourMinute(hour: 13, minute: 30),
              endTime: Date.hourMinute(hour: 18, minute: 0),
              countryCode: "AUT", countryName: "Autriche"),
    ]
}
