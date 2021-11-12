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

    public func totalProfit(in currency: Currency) -> Dollar? {
        let totalDeposits = activityReport.totalDeposits(madeIn: currency)
        guard let totalEquity = self.totalEquity(in: currency) else {
            return nil
        }

        return Dollar(currency: currency, amount: totalEquity.amount - totalDeposits.amount)
    }

    public func balance(in currency: Currency) -> Balance? {
        return balances.first(where: { $0.currency == currency })
    }

    public func totalEquity(in currency: Currency) -> Dollar? {
        guard let totalEquity = balance(in: currency)?.totalEquity else {
            return nil
        }

        return Dollar(currency: currency, amount: totalEquity)
    }

    public func marketValue(in currency: Currency) -> Dollar? {
        guard let marketValue = balance(in: currency)?.marketValue else {
            return nil
        }

        return Dollar(currency: currency, amount: marketValue)
    }

    public func cash(in currency: Currency) -> Dollar? {
        guard let cash = balance(in: currency)?.cash else {
            return nil
        }

        return Dollar(currency: currency, amount: cash)
    }


    public func printSummary() {

        print("---------- Account: \(account.type) - \(account.number) ----------------")
        activityReport.printSummary()
        Swift.print("\n")

        Swift.print("---------- Balances ----------------")
        for balance in balances {
            Swift.print("Total Balance in \(balance.currency):")
            Swift.print("\tCash: \(balance.cash)")
            Swift.print("\tMarket Value: \(balance.marketValue)")
            Swift.print("\tTotal equity: \(balance.totalEquity)")
        }

        Swift.print("\n")
        Swift.print("---------- Profit ----------------")
        if let totalProfit = totalProfit(in: .CAD)?.amount {
            Swift.print("Total profits in CAD: \(totalProfit)")
        }
        Swift.print("\n\n\n")
    }

    public func printDetail() {
        
    }
}

