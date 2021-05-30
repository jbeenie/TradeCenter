//
//  GetAccountOrders.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-25.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccountOrdersResult = Result<GetAccountOrdersResponse, Error>

public struct GetAccountOrdersResponse: Decodable {
    public let orders: [Order]
}

struct GetAccountOrdersAction: AccountAction {
    typealias Response = GetAccountOrdersResponse
    var path: String {
        "/v1/accounts/\(accountNumber)/orders"
    }

    let accountNumber: String
    let interval: DateInterval
    let stateFilter: OrderStateFilterType
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var queryItems: [URLQueryItem]? {
        let startTimeItem = URLQueryItem(name: "startTime", value: QuestTradeAPI.responseDateFormatter.string(from: interval.start))
        let endTimeItem = URLQueryItem(name: "endTime", value: QuestTradeAPI.responseDateFormatter.string(from: interval.end))
        let stateFilterItem = URLQueryItem(name: "stateFilter", value: stateFilter.rawValue)
        return [startTimeItem, endTimeItem, stateFilterItem]
    }
}
