//
//  QuestTradeAPI.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public protocol QuestTradeAPIInterface {
    static func getAccessToken(refreshToken: String, completion: @escaping (GetAccessTokenResult) -> Void)
    func getAccounts(accessToken: String, tokenType: String, completion: @escaping (GetAccountsResult) -> Void)
    func getAccountExecutions(accountNumber: String, startTime: String, endTime: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountExecutionsResult) -> Void)
    func getAccountActivities(accountNumber: String, startTime: String, endTime: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountActivitiesResult) -> Void)
    func getAccountOrders(accountNumber: String, startTime: String, endTime: String, filter: OrderStateFilterType, accessToken: String, tokenType: String, completion: @escaping (GetAccountOrdersResult) -> Void)
    func getAccountBalances(accountNumber: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountBalancesResult) -> Void)
    func getAccountPositions(accountNumber: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountPositionsResult) -> Void)
}

public final class QuestTradeAPI: QuestTradeAPIInterface {
    public static func getAccessToken(refreshToken: String,
                               completion: @escaping (GetAccessTokenResult) -> Void) {
        let action = GetAccessTokenAction(refreshToken: refreshToken)
        authenticationActionHandler.run(action: action, completion: completion)
    }

    public func getAccounts(accessToken: String,
                            tokenType: String,
                            completion: @escaping (GetAccountsResult) -> Void) {
        let action = GetAccountsAction(accessToken: accessToken, tokenType: tokenType)
        actionHandler.run(action: action, completion: completion)
    }
    
    public func getAccountExecutions(accountNumber: String,
                                     startTime: String,
                                     endTime: String,
                                     accessToken: String,
                                     tokenType: String,
                                     completion: @escaping (GetAccountExecutionsResult) -> Void) {
        let action = GetAccountExecutionsAction(accountNumber: accountNumber, startTime: startTime, endTime: endTime, accessToken: accessToken, tokenType: tokenType)
        actionHandler.run(action: action, completion: completion)
    }

    public func getAccountActivities(accountNumber: String, startTime: String, endTime: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountActivitiesResult) -> Void) {
        let action = GetAccountActivitiesAction(accountNumber: accountNumber,
                                                startTime: startTime,
                                                endTime: endTime,
                                                accessToken: accessToken,
                                                tokenType: tokenType)
        actionHandler.run(action: action, completion: completion)
    }

    public func getAccountOrders(accountNumber: String, startTime: String, endTime: String, filter: OrderStateFilterType, accessToken: String, tokenType: String, completion: @escaping (GetAccountOrdersResult) -> Void) {
        let action = GetAccountOrdersAction(accountNumber: accountNumber,
                                                startTime: startTime,
                                                endTime: endTime,
                                                stateFilter: filter,
                                                accessToken: accessToken,
                                                tokenType: tokenType)
        actionHandler.run(action: action, completion: completion)
    }

    public func getAccountBalances(accountNumber: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountBalancesResult) -> Void) {
        let action = GetAccountBalancesAction(accountNumber: accountNumber,
                                                accessToken: accessToken,
                                                tokenType: tokenType)
        actionHandler.run(action: action, completion: completion)
    }

    public func getAccountPositions(accountNumber: String, accessToken: String, tokenType: String, completion: @escaping (GetAccountPositionsResult) -> Void) {
        let action = GetAccountPositionsAction(accountNumber: accountNumber,
                                                accessToken: accessToken,
                                                tokenType: tokenType)
        actionHandler.run(action: action, completion: completion)
    }

    private let actionHandler: HttpActionHandler
    private static let authenticationActionHandler = QuestTradeAuthenticationHttpActionHandler()

    // MARK: - Initializer

    public init?(baseURLString: String) {
        guard let baseURL = URL(string: baseURLString) else {
            return nil
        }

        self.actionHandler = HttpActionHandler(baseUrl: baseURL)
    }
}
