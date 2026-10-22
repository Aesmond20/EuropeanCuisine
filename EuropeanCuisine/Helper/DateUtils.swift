//
//  DateUtils.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

enum DateUtils {
    static func closingStatusText(startTime: Date,
                                  endTime: Date,
                                  now: Date,
                                  closingSoonWindow: Int,
                                  recentlyClosedWindow: Int) -> String? {
        let localCalendar = Calendar.current

        guard let start = todayDate(fromUTCTimeOf: startTime, relativeTo: now,
                                    calendar: localCalendar),
            let end = todayDate(fromUTCTimeOf: endTime, relativeTo: now, calendar: localCalendar),
            let minutesToClose = localCalendar.dateComponents([.minute], from: now, to: end)
            .minute
        else {
            return nil
        }

        if (1 ... closingSoonWindow).contains(minutesToClose) {
            return String(localized: .dateClosingStatusClosesIn(minutes: minutesToClose))
        } else if (-recentlyClosedWindow ... 0).contains(minutesToClose) {
            return String(localized: .dateClosingStatusClosedAgo(minutes: -minutesToClose))
        } else {
            let startText = start.formatted(date: .omitted, time: .shortened)
            let endText = end.formatted(date: .omitted, time: .shortened)
            return "\(startText) - \(endText)"
        }
    }

    private static func todayDate(fromUTCTimeOf date: Date,
                                  relativeTo now: Date,
                                  calendar: Calendar) -> Date? {
        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)!

        let components = utcCalendar.dateComponents([.hour, .minute], from: date)

        guard let hour = components.hour, let minute = components.minute else {
            return nil
        }

        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: now)
    }
}
