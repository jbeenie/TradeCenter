//
//  GetAccountsAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccountsResult = Result<GetAccountsResponse, Error>

public struct GetAccountsResponse: Decodable {
    public let accounts: [Account]
    public let userId: Int
}

struct GetAccountsAction: AccountAction {

    typealias Response = GetAccountsResponse

    let path: String = "/v1/accounts"
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String
}
