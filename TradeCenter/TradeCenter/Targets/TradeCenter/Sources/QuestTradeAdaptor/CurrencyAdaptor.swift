//
//  CurrencyAdaptor.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-05-24.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit
import TradeCenterModel

extension TradeCenterModel.Currency {
    init(_ currency: QuestTradeKit.Currency) {
        switch currency {
        case .CAD:
            self = .CAD
        case .USD:
            self = .USD
        }
    }
}
