//
//  Trade.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public protocol Trade: Activity {
    /// The date that the trade settled.
    var settlementDate: Date { get }

    /// The amount of units traded.
    var quantity: Double { get }

    /// The symbol of the equity traded.
    var symbol: String { get }

    /// The amount of commission paid to execute the trade.
    var commission: Double { get }

    /// The currency of the amount paid or received.
    var currency: Currency { get }

    /// The amount of dollars paid or received in the trade.
    var amount: Double { get }
}
