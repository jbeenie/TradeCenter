//
//  QTSession.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public class QTSession {
    private let accessToken: String
    private let tokenType: String
    private let api: QuestTradeAPIInterface

    public init?(accessToken: String, baseURLString: String, tokenType: String) {
        guard let api = QuestTradeAPI(baseURLString: baseURLString) else {
            return nil
        }

        self.accessToken = accessToken
        self.tokenType = tokenType
        self.api = api
    }

    public func getAccounts(completion: @escaping (GetAcountsResult) -> Void) {
        api.getAccounts(accessToken: accessToken, tokenType: tokenType, completion: completion)
    }
}
