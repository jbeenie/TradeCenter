//
//  GetAccessTokenAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccessTokenResult = Result<GetAccessTokenResponse, Error>

public struct GetAccessTokenResponse: Decodable {
    public let authenticated: Bool
    public let access_token: String
    public let api_server: String
    public let expires_in: String
    public let refresh_token: String
    public let token_type: String
}

struct GetAccessTokenAction: HttpAction {

    typealias Response = GetAccessTokenResponse

    let path: String = "/oauth2/token"
    let method: HttpMethod = .get
    let refreshToken: String

    var queryItems: [URLQueryItem]? {
        let grantTypeQuerryItem = URLQueryItem(name: "grant_type", value: "refresh_token")
        let refreshTokenQuerryItem = URLQueryItem(name: "refresh_token", value: refreshToken)
        return [grantTypeQuerryItem, refreshTokenQuerryItem]
    }
}
