//
//  Account.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Account: Decodable {
    public let type: AccountType
    public let number: String
    public let status: AccountStatus
    public let isPrimary: Bool
    public let isBilling: Bool
    public let clientAccountType: ClientAccountType
}
