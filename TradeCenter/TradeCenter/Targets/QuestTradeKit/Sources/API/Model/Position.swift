//
//  Position.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-25.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Position: Decodable {
    public let symbol: String
    public let symbolId: Int
    public let openQuantity: Double
    public let closedQuantity: Double
    public let currentMarketValue: Double
    public let currentPrice: Double
    public let averageEntryPrice: Double
    public let closedPnl: Double
    public let openPnl: Double
    public let totalCost: Double
    public let isRealTime: Bool
    public let isUnderReorg: Bool
}
