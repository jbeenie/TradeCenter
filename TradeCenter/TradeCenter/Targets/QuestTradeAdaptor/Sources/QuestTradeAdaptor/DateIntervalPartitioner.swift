//
//  DateInterval.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-05-30.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public class DateIntervalPartitioner {
    public enum Granularity {
        case year
        case month
        case week
        case day
    }

    let calendar = Calendar.current
    let granularity: Granularity

    public init(granularity: Granularity) {
        self.granularity = granularity
    }

    public func partition(interval: DateInterval) -> [DateInterval] {
        guard var startInterval = self.interval(containing: interval.start),
            var endInterval = self.interval(containing: interval.end) else {
                return []
        }

        if startInterval == endInterval {
            // the original interval was sufficient partitioned to begin with
            return [interval]
        }

        var intervals = [DateInterval]()
        startInterval.start = interval.start
        intervals.append(startInterval)

        var previousInterval = startInterval

        while let nextInterval = self.nextInterval(after: previousInterval.start), nextInterval != endInterval {
            intervals.append(nextInterval)
            previousInterval = nextInterval
        }

        endInterval.end = interval.end
        intervals.append(endInterval)
        return intervals
    }

    internal func nextInterval(after date: Date) -> DateInterval? {
        guard let startDateOfNextInterval = interval(containing: date)?.end.sameTimeTheDayAfter else {
            return nil
        }

        return interval(containing: startDateOfNextInterval)
    }

    internal func interval(containing date: Date) -> DateInterval? {
        let component = Calendar.Component(granularity: granularity)
        return calendar.dateInterval(of: component, for: date)
    }
}

private extension Calendar.Component {
    init(granularity: DateIntervalPartitioner.Granularity) {
        switch granularity {
        case .year:
            self = .year
        case .month:
            self = .month
        case .week:
            self = .weekOfYear
        case .day:
            self = .day
        }
    }
}

extension Date {
    var sameTimeTheDayAfter: Date {
        return sameTimeNextDay()
    }

    var sameTimeTheDayBefore: Date {
        return sameTimeNextDay(inDirection: .backward)
    }

    private func sameTimeNextDay(inDirection direction: Calendar.SearchDirection = .forward,
                                 using calendar: Calendar = .current) -> Date {
        let components = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: self)
        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction)!
    }
}
