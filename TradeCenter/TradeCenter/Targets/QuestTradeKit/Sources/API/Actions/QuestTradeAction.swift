//
//  QuestTradeAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-05-04.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public protocol QuestTradeAction: HttpAction {

}

extension QuestTradeAction {
    var jsonDecoder: JSONDecoder {
        let iso8601Full: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
          formatter.calendar = Calendar(identifier: .iso8601)
          formatter.timeZone = TimeZone(secondsFromGMT: 0)
          formatter.locale = Locale(identifier: "en_US_POSIX")
          return formatter
        }()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(iso8601Full)
        return decoder
    }
}
