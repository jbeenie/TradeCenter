//
//  GetAccountPositions.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-25.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccountPositionsResult = Result<GetAccountPositionsResponse, Error>

public struct GetAccountPositionsResponse: Decodable {
    public let positions: [Position]
}

struct GetAccountPositionsAction: AccountAction {
    typealias Response = GetAccountPositionsResponse
    var path: String {
        "/v1/accounts/\(accountNumber)/positions"
    }

    let accountNumber: String
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var queryItems: [URLQueryItem]? {
        return nil
    }
}
