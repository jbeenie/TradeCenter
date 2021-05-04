//
//  DateDecodingTests.swift
//  DateDecodingTests
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import XCTest
@testable import QuestTradeKit

class DateDecodingTests: XCTestCase {
    let iso8601Full: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()

    func testDecodeQuestTradeDate() {
        guard let url = Bundle(for: DateDecodingTests.self).url(forResource: "Date", withExtension: ".json", subdirectory: nil, localization: nil) else {
            XCTFail("Failled to find URL.")
            return
        }

        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Failed to load Data from file.")
            return
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(iso8601Full)

        do {
            let container = try decoder.decode(DateContainer.self, from: data)
            XCTAssertEqual(container.date.description, "2011-02-16 05:00:00 +0000")
        } catch let error {
            XCTFail("Failed to decode data into Date. Error: \(error)")
            return
        }
    }

    struct DateContainer: Decodable {
        let date: Date
    }
}
