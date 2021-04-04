//
//  QTSession.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit

class QTSession {
    private let accessToken: String
    private let tokenType: String
    private let api: QuestTradeAPIInterface

    init?(accessToken: String, baseURLString: String, tokenType: String) {
        guard let api = QuestTradeAPI(baseURLString: baseURLString) else {
            return nil
        }

        self.accessToken = accessToken
        self.tokenType = tokenType
        self.api = api
    }
}
