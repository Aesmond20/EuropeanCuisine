//
//  DateUtils.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 10/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import Foundation

enum DateUtils {
    static func closingStatusText(startTime: Date, endTime: Date, now: Date, closingSoonWindow: Int,
                                  recentlyClosedWindow: Int) -> String? {
        let calendrier = Calendar.current
        let hourMinute = calendrier.dateComponents([.hour, .minute], from: endTime)

        guard let hourOfEnd = hourMinute.hour,
              let minuteOfEnd = hourMinute.minute,
              let endTime = calendrier.date(bySettingHour: hourOfEnd,
                                            minute: minuteOfEnd,
                                            second: 0,
                                            of: now),
              let minutesToClose = Calendar.current.dateComponents([.minute],
                                                                   from: now,
                                                                   to: endTime).minute else {
            return nil
        }

        if (1 ... closingSoonWindow).contains(minutesToClose) {
            return String(localized: .dateClosingStatusClosesIn(minutes: minutesToClose))
        } else if (-recentlyClosedWindow ... 0).contains(minutesToClose) {
            return String(localized: .dateClosingStatusClosedAgo(minutes: -minutesToClose))
        } else {
            let start = startTime.formatted(date: .omitted, time: .shortened)
            let end = endTime.formatted(date: .omitted, time: .shortened)

            return "\(start) - \(end)"
        }
    }
}
