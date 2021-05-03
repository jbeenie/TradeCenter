//
//  Deposit.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Deposit: Activity {
    public let description: String
    
    /// The date of the deposit.
    public let date: Date

    /// The amount deposited.
    public let amount: Double

    /// The currency of the deposited amount.
    public let currency: Currency
}
