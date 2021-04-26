//
//  Balance.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-25.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Balance: Decodable {
    public let currency: Currency
    public let cash: Double
    public let marketValue:  Double
    public let totalEquity:  Double
    public let buyingPower: Double
    public let maintenanceExcess: Double
    public let isRealTime: Bool
}
