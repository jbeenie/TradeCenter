//
//  Account.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Account: Hashable {
    public let type: AccountType
    public let number: String

    public init(type: AccountType, number: String)  {
        self.type = type
        self.number = number
    }
}

public enum AccountType: String, Decodable {
    case Cash    // Cash account.
    case Margin  // Margin account.
    case TFSA    // Tax Free Savings Account.
    case RRSP    // Registered Retirement Savings Plan.
    case SRRSP   // Spousal RRSP.
    case LRRSP   // Locked-In RRSP.
    case LIRA    // Locked-In Retirement Account.
    case LIF     // Life Income Fund.
    case RIF     // Retirement Income Fund.
    case SRIF    // Spousal RIF.
    case LRIF    // Locked-In RIF.
    case RRIF    // Registered RIF.
    case PRIF    // Prescribed RIF.
    case RESP    // Individual Registered Education Savings Plan.
    case FRESP   // Family RESP.
}
