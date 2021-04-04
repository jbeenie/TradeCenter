//
//  GetAcountsAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAcountsResult = Result<GetAcountsResponse, Error>

public struct GetAcountsResponse: Decodable {
    public let accounts: [Account]
    public let userId: Int
}

struct GetAcountsAction: HttpAction {

    typealias Response = GetAcountsResponse

    let path: String = "/v1/accounts"
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var headers: [HttpHeader] {
        return [(key: "Authorization", value: "\(tokenType) \(accessToken)")]
    }
}
