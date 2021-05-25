//
//  ActivityFactory.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-05-24.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit
import TradeCenterModel

enum ActivityType {
    static let buy = "Buy"
    static let deposit = "CON"
    static let dividend = "DIV"
    static let forExchange = "FXT"
    static let sell = "Sell"
    // TODO: Add other acticity types
}

public class ActivityFactory {
    public static func createActivity(from activity: QuestTradeKit.Activity) -> TradeCenterModel.Activity? {
        switch activity.action {
        case ActivityType.buy:
            return Buy(description: activity.description,
                       date: activity.transactionDate,
                       settlementDate: activity.settlementDate,
                       symbol: activity.symbol,
                       quantity: activity.quantity,
                       amount: activity.netAmount,
                       commission: activity.commission,
                       currency: Currency(activity.currency))

        case ActivityType.deposit:
            // TODO: Convert deposits
            return nil

        case ActivityType.dividend:
            return TradeCenterModel.Dividend(
                description: activity.description,
                date: activity.transactionDate, // TODO: Revise (Options: transaction/trade/settlement date)
                currency: Currency(activity.currency),
                amount: activity.netAmount, // TODO: Revise (Options net/gross amount)
                symbol: activity.symbol)
        case ActivityType.forExchange:
            // TODO: Convert deposits
            return nil

        case ActivityType.sell:
            return Sell(description: activity.description,
                       date: activity.transactionDate,
                       settlementDate: activity.settlementDate,
                       symbol: activity.symbol,
                       quantity: activity.quantity,
                       amount: activity.netAmount,
                       commission: activity.commission,
                       currency: Currency(activity.currency))

        default:
            print("unknown activity type: \(activity.type)")
            return nil
        }
    }

    private init() {}
}

