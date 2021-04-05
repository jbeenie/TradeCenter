//
//  GetAcountExecutionsAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAcountExecutionsResult = Result<GetAcountExecutionsResponse, Error>

public struct GetAcountExecutionsResponse: Decodable {
    public let executions: [Execution]
}

struct GetAcountExecutionsAction: AccountAction {
    typealias Response = GetAcountExecutionsResponse
    var path: String {
        "/v1/accounts/\(accountNumber)/executions"
    }
    
    let accountNumber: String
    let startTime: String
    let endTime: String
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var queryItems: [URLQueryItem]? {
        let startTimeItem = URLQueryItem(name: "startTime", value: startTime)
        let endTimeItem = URLQueryItem(name: "endTime", value: endTime)
        return [startTimeItem, endTimeItem]
    }
}
