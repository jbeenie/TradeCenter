//
//  Balance.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Balance {
    /// The currency the balance is in.
    public let currency: Currency

    /// The amount of cash in the acocunt.
    public let cash: Double

    /// The market value of the equities held in the acocunt.
    public let marketValue:  Double

    /// The sum of the market value and cash in the account.
    public let totalEquity:  Double

    /// The buying power in the account.
    public let buyingPower: Double

    public let maintenanceExcess: Double

    public init(currency: Currency,
                cash: Double,
                marketValue:  Double,
                totalEquity:  Double,
                buyingPower: Double,
                maintenanceExcess: Double) {
        self.currency = currency
        self.cash = cash
        self.marketValue = marketValue
        self.totalEquity = totalEquity
        self.buyingPower = buyingPower
        self.maintenanceExcess = maintenanceExcess
    }
}
