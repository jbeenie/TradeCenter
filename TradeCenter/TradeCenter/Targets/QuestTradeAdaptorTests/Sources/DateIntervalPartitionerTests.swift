//
//  DateIntervalPartitionerTests.swift
//  QuestTradeKitTests
//
//  Created by Jeremie Benhamron on 2021-06-06.
//  Copyright © 2021 Beenie. All rights reserved.
//

import XCTest
import Foundation
@testable import QuestTradeAdaptor

class QuestTradeAdaptorTests: XCTestCase {

    func testPartitionIntervalIntoWeeks() throws {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let dateInterval = self.dateInterval(from: "2021-03-01T08:00:00", to: "2021-03-24T08:00:00")
        let intervals = dateIntervalPartioner.partition(interval: dateInterval)
        let expected = [
            self.dateInterval(from: "2021-03-01T08:00:00", to: "2021-03-08T08:00:00"),
            self.dateInterval(from: "2021-03-07T08:00:00", to: "2021-03-14T08:00:00"),
            self.dateInterval(from: "2021-03-014T08:00:00", to: "2021-03-21T07:00:00"),
            self.dateInterval(from: "2021-03-21T07:00:00", to: "2021-03-24T08:00:00")
        ]
        XCTAssertEqual(intervals.count, expected.count)
        for (expected, result) in zip(expected, intervals) {
            XCTAssertEqual(result, expected)
        }

    }

    func testNextInterval() {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let date = self.date(from: "2021-03-02T11:11:11")
        guard let result = dateIntervalPartioner.nextInterval(after: date) else {
            XCTFail("Could get interval contianing date.")
            return
        }

        let expected = dateInterval(from: "2021-03-07T08:00:00", to: "2021-03-14T08:00:00")
        XCTAssertEqual(result, expected)
    }

    func testNextInterval2() {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let date = self.date(from: "2021-03-07T08:00:00")
        guard let result = dateIntervalPartioner.nextInterval(after: date) else {
            XCTFail("Could get interval contianing date.")
            return
        }

        let expected = dateInterval(from: "2021-03-14T08:00:00", to: "2021-03-21T07:00:00")
        XCTAssertEqual(result, expected)
    }

    func testNextInterval3() {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let date = self.date(from: "2021-03-07T07:59:59")
        guard let result = dateIntervalPartioner.nextInterval(after: date) else {
            XCTFail("Could get interval contianing date.")
            return
        }

        let expected = dateInterval(from: "2021-03-07T08:00:00", to: "2021-03-14T08:00:00")
        XCTAssertEqual(result, expected)
    }

    func testIntervalContainingDate1() {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let date = self.date(from: "2021-03-02T11:11:11")
        guard let result = dateIntervalPartioner.interval(containing: date) else {
            XCTFail("Could get interval contianing date.")
            return
        }

        let expected = dateInterval(from: "2021-02-28T08:00:00", to: "2021-03-07T08:00:00")
        XCTAssertEqual(result, expected)
    }

    func testIntervalContainingDate2() {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let date = self.date(from: "2021-03-07T08:00:00")
        guard let result = dateIntervalPartioner.interval(containing: date) else {
            XCTFail("Could get interval contianing date.")
            return
        }

        let expected = dateInterval(from: "2021-03-07T08:00:00", to: "2021-03-14T08:00:00")
        XCTAssertEqual(result, expected)
    }

    func testIntervalContainingDate3() {
        let dateIntervalPartioner = DateIntervalPartitioner(granularity: .week)
        let date = self.date(from: "2021-03-07T07:59:59")
        guard let result = dateIntervalPartioner.interval(containing: date) else {
            XCTFail("Could get interval contianing date.")
            return
        }

        let expected = dateInterval(from: "2021-02-28T08:00:00", to: "2021-03-07T08:00:00")
        XCTAssertEqual(result, expected)
    }

    func testSameTimeTheDayAfter() {
        let date = self.date(from: "2021-03-02T11:11:11")
        let result = date.sameTimeTheDayAfter
        let expected = self.date(from: "2021-03-03T11:11:11")
        XCTAssertEqual(result, expected)
    }

    func testSameTimeTheDayBefore() {
        let date = self.date(from: "2021-03-02T11:11:11")
        let result = date.sameTimeTheDayBefore
        let expected = self.date(from: "2021-03-01T11:11:11")
        XCTAssertEqual(result, expected)
    }

    func testDateIntervalEquality() {
        let dateInterval1 = self.dateInterval(from: "2021-02-28T08:00:00", to: "2021-03-07T08:00:00")
        let dateInterval2 = self.dateInterval(from: "2021-02-28T08:00:00", to: "2021-03-07T08:00:00")
        XCTAssertEqual(dateInterval1, dateInterval2)
    }

    func date(from string: String) -> Date {
        return DateFormatter.iso8601.date(from: string)!
    }

    func dateInterval(from start: String, to end: String) -> DateInterval {
        DateInterval(start: date(from: start), end: date(from: end))
    }
}
