//
//  Buy.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Buy: Trade {
    public let description: String
    
    public let date: Date
    public let settlementDate: Date

    public let symbol: String
    public let quantity: Double

    public let amount: Double
    public let commission: Double
    public let currency: Currency

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

