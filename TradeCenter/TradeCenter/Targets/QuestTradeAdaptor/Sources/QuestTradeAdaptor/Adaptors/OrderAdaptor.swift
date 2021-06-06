//
//  DepositAdaptor.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-05-30.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import TradeCenterModel
import QuestTradeKit

extension TradeCenterModel.Order {
    init(order: QuestTradeKit.Order) {
        self.init()
        // TODO: convert order
    }
}
