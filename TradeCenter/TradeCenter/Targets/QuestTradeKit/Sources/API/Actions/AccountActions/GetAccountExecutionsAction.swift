//
//  GetAccountExecutionsAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccountExecutionsResult = Result<GetAccountExecutionsResponse, Error>

public struct GetAccountExecutionsResponse: Decodable {
    public let executions: [Execution]
}

struct GetAccountExecutionsAction: AccountAction {
    typealias Response = GetAccountExecutionsResponse
    var path: String {
        "/v1/accounts/\(accountNumber)/executions"
    }
    
    let accountNumber: String
    let startTime: Date
    let endTime: Date
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var queryItems: [URLQueryItem]? {
        let startTimeItem = URLQueryItem(name: "startTime", value: QuestTradeAPI.responseDateFormatter.string(from: startTime))
        let endTimeItem = URLQueryItem(name: "endTime", value: QuestTradeAPI.responseDateFormatter.string(from: endTime))
        return [startTimeItem, endTimeItem]
    }
}
