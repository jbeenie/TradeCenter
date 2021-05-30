//
//  ForXConversion.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct ForXConversion: Activity {
    /// The date the currency was exchanged.
    public let date: Date

    /// The being exchanged.
    public let currency: Currency

    /// The currency received.
    public let obtainedCurrency: Currency

    /// The amount of money exchanged.
    public let amount: Double

    /// The amount of the `obtainedCurrency` obtained.
    public let obtainedAmount: Double

    public let description: String
}

public struct ForX: Activity {
    public var date: Date

    /// The currency received in the for exchange.
    public var currency: Currency

    /// The amount received in a for exchange conversion.
    public var amount: Double

    public var description: String

     public init(description: String,
                   date: Date,
                   currency: Currency,
                   amount: Double) {
           self.description = description
           self.date = date
           self.currency = currency
           self.amount = amount
       }
}
