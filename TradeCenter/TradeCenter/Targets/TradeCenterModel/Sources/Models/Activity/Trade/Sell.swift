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

    public let quantity: Double

    public let symbol: String

    public let commission: Double

    public let date: Date

    public let currency: Currency

    public let amount: Double

    public init(description: String,
                date: Date,
                settlementDate: Date,
                symbol: String,
                quantity: Double,
                amount: Double,
                commission: Double,
                currency: Currency) {
        self.description = description
        self.date = date
        self.settlementDate = settlementDate
        self.symbol = symbol
        self.quantity = quantity
        self.amount = amount
        self.commission = commission
        self.currency = currency
    }
}
