//
//  Dividend.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Dividend: Activity {
    public let description: String
    
    /// The date the dividend was received.
    public let date: Date

    /// The currency of dividend paid.
    public let currency: Currency

    /// The ammount paid.
    public let amount: Double

    /// The symbol of the equity the dividend was paid for.
    public let symbol: String
}
