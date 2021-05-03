//
//  Sell.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Sell: Trade {
    public let description: String
    
    public let settlementDate: Date

    public let quantity: Int

    public let symbol: String

    public let commission: Double

    public let date: Date

    public let currency: Currency

    public let amount: Double
}
