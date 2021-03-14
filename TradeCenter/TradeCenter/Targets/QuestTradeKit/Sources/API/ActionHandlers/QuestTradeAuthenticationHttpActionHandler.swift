//
//  QuestTradeAuthenticationHttpActionHandler.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

class QuestTradeAuthenticationHttpActionHandler: HttpActionHandler {

    private struct Constants {
        private static let baseURLString = "https://login.questrade.com"
        static let baseUrl = URL(string: baseURLString)!
    }

    // MARK: Init

    init() {
        super.init(baseUrl: Constants.baseUrl)
    }
}
