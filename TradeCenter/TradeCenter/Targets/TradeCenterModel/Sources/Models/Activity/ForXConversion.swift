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
