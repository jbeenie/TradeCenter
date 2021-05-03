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
    public let quantity: Int

    public let amount: Double
    public let commission: Double
    public let currency: Currency
}
