//
//  Execution.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Execution: Decodable {
    public let symbol: String
    public let symbolId: Int
    public let quantity: Int
    public let side: String
    public let price: Double
    public let id: Int
    public let orderId: Int
    public let orderChainId: Int
    public let exchangeExecId: String
    public let timestamp: String
    public let notes: String
    public let venue: String
    public let totalCost: Double
    public let orderPlacementCommission: Double
    public let commission: Double
    public let executionFee: Double
    public let secFee: Double
    public let canadianExecutionFee: Int
    public let parentId: Int
}


