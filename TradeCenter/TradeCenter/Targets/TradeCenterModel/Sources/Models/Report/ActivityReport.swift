//
//  ActivityReport.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-10-24.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct ActivityReport {
    public let dividends: [Dividend]
    public let deposits: [Deposit]
    public let forXs: [ForXConversion]
    public let sells: [Sell]
    public let buys: [Buy]

    public  var activities: [Activity] {
        return dividends + deposits + forXs + sells + buys
    }

    public var trades: [Trade] {
        return sells + buys
    }


    public func totalDeposits(madeIn currency: Currency) -> Dollar {
        return deposits.reduce(Dollar(currency: currency, amount: 0)) { totalDeposit, deposit in
            var amount = totalDeposit.amount
            if deposit.currency == currency {
                amount += deposit.amount
            }
            return Dollar(currency: currency, amount: amount)
        }
    }

    public func totalCommission(paidOn trades: [Trade], in currency: Currency) -> Dollar {
        return trades.reduce(Dollar(currency: currency, amount: 0)) { totalCommission, trade in
            var amount = totalCommission.amount
            if trade.currency == currency {
                amount += trade.commission
            }
            return Dollar(currency: currency, amount: amount)
        }
    }

    public func totalDividends(receivedIn currency: Currency) -> Dollar {
        return dividends.reduce(Dollar(currency: currency, amount: 0)) { total, dividend in
            var amount = total.amount
            if dividend.currency == currency {
                amount += dividend.amount
            }
            return Dollar(currency: currency, amount: amount)
        }
    }

    public init(activities: [Activity]) {
        self.buys = activities.compactMap { $0 as? Buy }
        self.sells = activities.compactMap { $0 as? Sell }
        self.forXs = activities.compactMap { $0 as? ForXConversion }
        self.deposits = activities.compactMap { $0 as? Deposit }
        self.dividends = activities.compactMap { $0 as? Dividend }
    }

    public func printSummary() {

        Swift.print("Summary:")
        Swift.print("---------- deposits ----------------")
        Swift.print("Total CAD deposits: \(totalDeposits(madeIn: .CAD).amount)")
        Swift.print("Total USD deposits: \(totalDeposits(madeIn: .USD).amount)")

        Swift.print("---------- dividends ----------------")
        Swift.print("Total dividends received in CAD: \(totalDividends(receivedIn: .CAD).amount)")
        Swift.print("Total dividends received in USD: \(totalDividends(receivedIn: .USD).amount)")

        Swift.print("---------- forX ----------------")

        Swift.print("---------- buys ----------------")
        Swift.print("Total commission paid for buys in CAD: \(totalCommission(paidOn: buys, in: .CAD).amount)")
        Swift.print("Total commission paid for buys in USD: \(totalCommission(paidOn: buys, in: .USD).amount)")

        Swift.print("---------- sells ----------------")
        Swift.print("Total commission paid on sells in CAD: \(totalCommission(paidOn: sells, in: .CAD).amount)")
        Swift.print("Total commission paid on sells in USD: \(totalCommission(paidOn: sells, in: .USD).amount)")

        Swift.print("---------- trades ----------------")
        Swift.print("Total commission paid on trades in CAD: \(totalCommission(paidOn: trades, in: .CAD).amount)")
        Swift.print("Total commission paid on trades in USD: \(totalCommission(paidOn: trades, in: .USD).amount)")

        Swift.print("----------- End Summary ---------------")
    }

    public func printDetail() {
        Swift.print("Detail:")
        Swift.print("---------- deposits: ----------------")
        for deposit in deposits {
            Swift.print("type: \(type(of: deposit)) - date: \(deposit.date) - desc: \(deposit.description)")
        }
        Swift.print("\n")

        Swift.print("---------- dividends ----------------")
        for dividend in dividends {
            Swift.print("type: \(type(of: dividend)) - date: \(dividend.date) - desc: \(dividend.description)")
        }
        Swift.print("\n")

        Swift.print("---------- dividends ----------------")
        for dividend in dividends {
            Swift.print("type: \(type(of: dividend)) - date: \(dividend.date) - desc: \(dividend.description)")
        }
        Swift.print("\n")

        Swift.print("---------- forX ----------------")
        for forX in forXs {
            Swift.print("type: \(type(of: forX)) - date: \(forX.date) - desc: \(forX.description)")
        }
        Swift.print("\n")

        Swift.print("---------- buys ----------------")
        for buy in buys {
            Swift.print("type: \(type(of: buy)) - date: \(buy.date) - desc: \(buy.description)")
        }
        Swift.print("\n")

        Swift.print("---------- sells ----------------")
        for sell in sells {
            Swift.print("type: \(type(of: sell)) - date: \(sell.date) - desc: \(sell.description)")
        }
        Swift.print("---------- End Detail ---------------")
    }
}
