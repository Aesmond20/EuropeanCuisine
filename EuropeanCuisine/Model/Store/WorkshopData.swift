//
//  WorkshopData.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 04/10/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import Foundation

enum WorkshopData {
    static let workshops: [Workshop] = [
        Workshop(id: UUID(),
                 name: "French Pastry Masterclass",
                 category: "Recipe",
                 bookedCapacity: 7, capacityMax: 13,
                 startTime: date(hour: 10, minute: 0),
                 endTime: date(hour: 12, minute: 0),
                 description: """
                 Discover the secrets of French pastry and learn how to prepare \
                 a delicate classic with a professional pastry chef.
                 """,
                 pictureURL: "https://picsum.photos/seed/french/600/400", location: "Room 10C",
                 isVegan: false,
                 isPRM: true,
                 isFamilyFriendly: true),
        Workshop(id: UUID(),
                 name: "Taste of Italy",
                 category: "Recipe",
                 bookedCapacity: 12, capacityMax: 17,
                 startTime: date(hour: 11, minute: 30),
                 endTime: date(hour: 13, minute: 0),
                 description: """
                 Travel through Italy with a hands-on workshop dedicated to \
                 fresh pasta, traditional sauces and Mediterranean flavours.
                 """,
                 pictureURL: "https://images.unsplash.com/photo-1556761223-4c4282c73f77",
                 location: "Room 10B",
                 isVegan: true,
                 isPRM: true,
                 isFamilyFriendly: true),
        Workshop(id: UUID(),
                 name: "European Street Food",
                 category: "Discovery",
                 bookedCapacity: 0, capacityMax: 18,
                 startTime: date(hour: 13, minute: 30),
                 endTime: date(hour: 14, minute: 30),
                 description: """
                 Explore some of Europe's most iconic street food traditions \
                 and discover the stories behind their recipes.
                 """,
                 pictureURL: "https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba",
                 location: "Room 5C",
                 isVegan: false,
                 isPRM: true,
                 isFamilyFriendly: true),
        Workshop(id: UUID(),
                 name: "Mediterranean Flavours",
                 category: "Recipe",
                 bookedCapacity: 5, capacityMax: 15,
                 startTime: date(hour: 14, minute: 30),
                 endTime: date(hour: 16, minute: 0),
                 description: """
                                  Learn how Mediterranean ingredients come together in \
                 simple, colourful and generous dishes.
                 """,
                 pictureURL: "https://images.unsplash.com/photo-1547592180-85f173990554",
                 location: "Room 3A",
                 isVegan: true,
                 isPRM: true,
                 isFamilyFriendly: false),
        Workshop(id: UUID(),
                 name: "European Fashion & Food",
                 category: "Fashion show",
                 bookedCapacity: 25, capacityMax: 30,
                 startTime: date(hour: 16, minute: 30),
                 endTime: date(hour: 17, minute: 30),
                 description: """
                 A celebration of European creativity where fashion, food \
                 and cultural influences meet on the same stage.
                 """,
                 pictureURL: "https://images.unsplash.com/photo-1483985988355-763728e1935b",
                 location: "Room 8D",
                 isVegan: true,
                 isPRM: true,
                 isFamilyFriendly: true),
        Workshop(id: UUID(),
                 name: "Kids' European Baking",
                 category: "Kids & family",
                 bookedCapacity: 10, capacityMax: 10,
                 startTime: date(hour: 15, minute: 0),
                 endTime: date(hour: 16, minute: 0),
                 description: """
                 A fun family workshop where young chefs discover \
                 European baking traditions and create their own sweet treats.
                 """,
                 pictureURL: "https://images.unsplash.com/photo-1556910103-1c02745aae4d",
                 location: "Room 2B",
                 isVegan: false,
                 isPRM: true,
                 isFamilyFriendly: true),
        Workshop(id: UUID(),
                 name: "From Farm to Table",
                 category: "Keynote",
                 bookedCapacity: 40, capacityMax: 40,
                 startTime: date(hour: 17, minute: 30),
                 endTime: date(hour: 18, minute: 30),
                 description: """
                 Meet European producers and chefs to discover how \
                 local ingredients travel from the farm to our plates.
                 """,
                 pictureURL: "https://images.unsplash.com/photo-1500595046743-cd271d694d30",
                 location: "Room 7A",
                 isVegan: true,
                 isPRM: true,
                 isFamilyFriendly: true),
    ]

    private static func date(hour: Int, minute: Int) -> Date {
        Calendar.current.date(bySettingHour: hour,
                              minute: minute,
                              second: 0,
                              of: Date()) ?? Date()
    }
}
