//
//  AccountAdaptor.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-05-24.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit
import TradeCenterModel

extension TradeCenterModel.Account {
    public init(_ account: QuestTradeKit.Account) {
        self.init(type: AccountType(account.type), number: account.number)
    }
}

extension TradeCenterModel.AccountType {
    init(_ accountType: QuestTradeKit.AccountType) {
        switch accountType {
        case .Cash:
            self = .Cash
        case .Margin:
            self = .Margin
        case .TFSA:
            self = .TFSA
        case .RRSP:
            self = .RRSP
        case .SRRSP:
            self = .SRRSP
        case .LRRSP:
            self = .LRRSP
        case .LIRA:
            self = .LIRA
        case .LIF:
            self = .LIF
        case .RIF:
            self = .RIF
        case .SRIF:
            self = .SRIF
        case .LRIF:
            self = .LRIF
        case .RRIF:
            self = .RRIF
        case .PRIF:
            self = .PRIF
        case .RESP:
            self = .RESP
        case .FRESP:
            self = .FRESP
        }
    }
}


