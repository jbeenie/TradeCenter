//
//  AccountManager.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public class AccountManager {
    private(set) var account: Account
    private weak var dataSource: AccountManagerDataSource?

    init(account: Account, dataSource: AccountManagerDataSource) {
        self.account = account
        self.dataSource = dataSource
    }


    public func getExecutions(interval: DateInterval, completion: @escaping ([Execution]) -> Void) {
        dataSource?.getExecutions(for: account, interval: interval) { executions in
            completion(executions)
        }
    }

    public func getActivities(interval: DateInterval, completion: @escaping ([Activity]) -> Void) {
        dataSource?.getActivities(for: account, interval: interval) { activities in
            completion(activities)
        }
    }

    public func getAccountOrders(interval: DateInterval, completion: @escaping ([Order]) -> Void) {
        dataSource?.getAccountOrders(for: account, interval: interval) { orders in
            completion(orders)
        }
    }

    public func getBalances(completion: @escaping ([Balance]) -> Void) {
        dataSource?.getBalances(for: account) { balances in
            completion(balances)
        }
    }

    public func getPositions(completion: @escaping ([Position]) -> Void) {
        dataSource?.getPositions(for: account) { positions in
            completion(positions)
        }
    }
}
