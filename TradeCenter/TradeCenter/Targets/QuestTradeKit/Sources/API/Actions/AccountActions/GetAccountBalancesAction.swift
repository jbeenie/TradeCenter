//
//  GetAccountBalances.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-25.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccountBalancesResult = Result<GetAccountBalancesResponse, Error>

public struct GetAccountBalancesResponse: Decodable {
    public let perCurrencyBalances: [Balance]
    public let combinedBalances: [Balance]
    public let sodPerCurrencyBalances: [Balance]
    public let sodCombinedBalances: [Balance]
}

struct GetAccountBalancesAction: AccountAction {
    typealias Response = GetAccountBalancesResponse
    var path: String {
        "/v1/accounts/\(accountNumber)/balances"
    }

    let accountNumber: String
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var queryItems: [URLQueryItem]? {
        return nil
    }
}
