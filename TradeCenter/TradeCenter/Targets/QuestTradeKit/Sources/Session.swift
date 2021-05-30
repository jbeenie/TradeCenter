//
//  QTSession.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public class Session {
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

    public func getAccounts(completion: @escaping (GetAccountsResult) -> Void) {
        api.getAccounts(accessToken: accessToken, tokenType: tokenType, completion: completion)
    }

    public func getAccountExecutions(accountNumber: String,
                                     interval: DateInterval,
                                     completion: @escaping (GetAccountExecutionsResult) -> Void) {
        api.getAccountExecutions(accountNumber: accountNumber,
                                 interval: interval,
                                 accessToken: accessToken,
                                 tokenType: tokenType,
                                 completion: completion)
    }

    public func getAccountActivities(accountNumber: String,
                                     interval: DateInterval,
                                     completion: @escaping (GetAccountActivitiesResult) -> Void) {
        api.getAccountActivities(accountNumber: accountNumber,
                                 interval: interval,
                                 accessToken: accessToken,
                                 tokenType: tokenType,
                                 completion: completion)
    }

    public func getAccountOrders(accountNumber: String,
                                     interval: DateInterval,
                                     filter: OrderStateFilterType,
                                     completion: @escaping (GetAccountOrdersResult) -> Void) {
        api.getAccountOrders(accountNumber: accountNumber,
                                 interval: interval,
                                 filter: filter,
                                 accessToken: accessToken,
                                 tokenType: tokenType,
                                 completion: completion)
    }

    public func getAccountBalances(accountNumber: String,
                                     completion: @escaping (GetAccountBalancesResult) -> Void) {
        api.getAccountBalances(accountNumber: accountNumber,
                                 accessToken: accessToken,
                                 tokenType: tokenType,
                                 completion: completion)
    }

    public func getAccountPositions(accountNumber: String,
                                     completion: @escaping (GetAccountPositionsResult) -> Void) {
        api.getAccountPositions(accountNumber: accountNumber,
                                 accessToken: accessToken,
                                 tokenType: tokenType,
                                 completion: completion)
    }
}
