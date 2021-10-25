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
        case day(UInt)
    }

    let calendar = Calendar.current
    let granularity: Granularity

    public init(granularity: Granularity) {
        self.granularity = granularity
    }

    public func partition(interval: DateInterval) -> [DateInterval] {
        switch granularity {
        case .year, .month, .week:
            return partitionIntoDateComponents(interval: interval)

        case .day(let numberOfDays):
            return partition(daysPerInterval: numberOfDays, interval: interval)
        }
    }

    // MARK: - Partioning by number of days

    public func partition(daysPerInterval: UInt, interval: DateInterval) -> [DateInterval] {
        if calendar.numberOfDaysBetween(interval.start, and: interval.end) < daysPerInterval {
            // the original interval was sufficient partitioned to begin with
            return [interval]
        }

        var intervals = [DateInterval]()
        var nextStartDate = interval.start
        repeat {
            var nextInterval = self.interval(startingAt: nextStartDate, lasting: daysPerInterval)!

            if interval.end < nextInterval.end {
                nextInterval.end = interval.end
            }

            intervals.append(nextInterval)
            nextStartDate = nextInterval.end
        } while nextStartDate < interval.end

        return intervals
    }

    internal func interval(startingAt date: Date, lasting numberOfDays: UInt) -> DateInterval? {
        guard let endDate = calendar.date(byAdding: .day, value: Int(numberOfDays), to: date) else {
            return nil
        }
        return DateInterval(start: date, end: endDate)
    }

    // MARK: - Partioning by date component

    public func partitionIntoDateComponents(interval: DateInterval) -> [DateInterval] {
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

// MARK: -

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

extension Calendar {
    // Number of days pass midnight, including a start date
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)

        return numberOfDays.day! + 1
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
