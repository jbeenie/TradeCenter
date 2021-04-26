//
//  Execution.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Order: Decodable {
    public struct Leg: Decodable {

    }
    public let id: Int
    public let symbol: String
    public let symbolId:  Int
    public let totalQuantity:  Int
    public let openQuantity:  Int
    public let filledQuantity:  Int?
    public let canceledQuantity: Int
    public let side: OrderSide
    public let orderType: OrderType
    public let limitPrice: Double
    public let stopPrice: Double?
    public let isAllOrNone: Bool
    public let isAnonymous: Bool
    public let icebergQty: Int?
    public let minQuantity: Int?
    public let avgExecPrice: Double?
    public let lastExecPrice: Double?
    public let source: String
    public let timeInForce: OrderTimeInForce
    public let gtdDate:  String?
    public let state: OrderState
    public let clientReasonStr: String?
    public let chainId: Int
    public let creationTime: String
    public let updateTime: String
    public let notes: String
    public let primaryRoute: String
    public let secondaryRoute: String
    public let orderRoute: String
    public let venueHoldingOrder: String
    public let comissionCharged: Double?
    public let exchangeOrderId: String
    public let isSignificantShareHolder: Bool
    public let isInsider: Bool
    public let isLimitOffsetInDollar: Bool
    public let userId: Int
    public let placementCommission: Double?
    public let legs: [Leg]
    public let strategyType: String
    public let triggerStopPrice: Double?
    public let orderGroupId: Int
    public let orderClass: OrderClass?
}


