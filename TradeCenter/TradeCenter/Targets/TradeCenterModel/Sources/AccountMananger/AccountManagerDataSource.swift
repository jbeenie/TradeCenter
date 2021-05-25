//
//  AccountManagerDataSource.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public protocol AccountManagerDataSource: class {
    func getExecutions(for account: Account, startTime: Date, endTime: Date,
                       completion: @escaping ([Execution]) -> Void)

    func getActivities(for account: Account, startTime: Date, endTime: Date,
                       completion: @escaping ([Activity]) -> Void)

    func getAccountOrders(for account: Account, startTime: Date, endTime: Date,
                          completion: @escaping ([Order]) -> Void)

    func getBalances(for account: Account,
                     completion: @escaping ([Balance]) -> Void)

    func getPositions(for account: Account,
                      completion: @escaping ([Position]) -> Void)
}
