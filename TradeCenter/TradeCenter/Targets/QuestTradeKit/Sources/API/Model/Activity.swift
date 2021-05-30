//
//  Activity.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-04.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Activity: Decodable {
    public let tradeDate: String
    public let transactionDate: Date
    public let settlementDate: Date
    public let action: String
    public let symbol: String
    public let symbolId: UInt64
    public let description: String
    public let currency: Currency
    public let quantity: Double
    public let price: Double
    public let commission: Double
    public let type: String

    /// Amount before commission
    public let grossAmount: Double

    /// Amount after commission
    public let netAmount: Double
}
