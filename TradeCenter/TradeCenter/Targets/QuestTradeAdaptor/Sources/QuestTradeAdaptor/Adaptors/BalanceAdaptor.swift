//
//  BalanceAdaptor.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-05-30.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import TradeCenterModel
import QuestTradeKit

extension TradeCenterModel.Balance {
    init(balance: QuestTradeKit.Balance) {
        self.init(
            currency: Currency(balance.currency),
            cash: balance.cash,
            marketValue: balance.marketValue,
            totalEquity: balance.totalEquity,
            buyingPower: balance.buyingPower,
            maintenanceExcess: balance.maintenanceExcess
        )
    }
}
