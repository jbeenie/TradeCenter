//
//  QuestTradeAccountAdaptor.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-16.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit
import TradeCenterModel

public class QuestTradeSessionAdaptor: AccountManagerDataSource {
    private var session: Session

    init(session: Session) {
        self.session = session
    }

    // MARK: - AccountManagerDataSource

    public func getExecutions(for account: TradeCenterModel.Account, startTime: Date, endTime: Date,
                              completion: @escaping ([TradeCenterModel.Execution]) -> Void) {
        session.getAccountExecutions(accountNumber: account.number, startTime: startTime, endTime: endTime) { result in
            switch result {
            case .success(let response):
                completion(response.executions.map { TradeCenterModel.Execution(execution: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getActivities(for account: TradeCenterModel.Account, startTime: Date, endTime: Date,
                              completion: @escaping ([TradeCenterModel.Activity]) -> Void) {
        session.getAccountActivities(accountNumber: account.number, startTime: startTime, endTime: endTime) { result in
            switch result {
            case .success(let response):
                completion(response.activities.compactMap { ActivityFactory.createActivity(from: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getAccountOrders(for account: TradeCenterModel.Account, startTime: Date, endTime: Date,
                                 completion: @escaping ([TradeCenterModel.Order]) -> Void) {
        session.getAccountOrders(accountNumber: account.number,
                                 startTime: startTime,
                                 endTime: endTime,
                                 filter: .All) { result in
            switch result {
            case .success(let response):
                completion(response.orders.map { TradeCenterModel.Order(order: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getBalances(for account: TradeCenterModel.Account,
                            completion: @escaping ([TradeCenterModel.Balance]) -> Void) {
        session.getAccountBalances(accountNumber: account.number) { result in
            switch result {
            case .success(let response):
                // TODO: Figure out what to do here
                //completion(response.perCurrencyBalances.map { TradeCenterModel.Balance(balance: $0) })
                break
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getPositions(for account: TradeCenterModel.Account,
                             completion: @escaping ([TradeCenterModel.Position]) -> Void) {
        session.getAccountPositions(accountNumber: account.number) { result in
            switch result {
            case .success(let response):
                completion(response.positions.map { TradeCenterModel.Position(position: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }
}
