//
//  AccountReport.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-11-07.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct AccountReport {
    public let activityReport: ActivityReport
    public let account: Account
    public let balances: [Balance]


    public init(activities: [Activity], account: Account, balances: [Balance]) {
        self.activityReport = ActivityReport(activities: activities)
        self.account = account
        self.balances = balances
    }

    public func printSummary() {

        print("---------- Account: \(account.type) - \(account.number) ----------------")
        activityReport.printSummary()
        Swift.print("\n\n\n")
    }

    public func printDetail() {
        Swift.print("Detail:")
        Swift.print("---------- Balances: ----------------")
        for balance in balances {
            Swift.print("type: \(type(of: balance)) - currency: \(balance.currency) - cash: \(balance.cash) - market Value: \(balance.marketValue) - total value: \(balance.totalEquity)")
        }
        Swift.print("\n")
        Swift.print("---------- End Detail ---------------")
        Swift.print("\n\n\n")
    }
}

