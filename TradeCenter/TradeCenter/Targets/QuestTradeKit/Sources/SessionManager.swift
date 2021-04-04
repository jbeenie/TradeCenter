//
//  QTSessionManager.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public class SessionManager {
    public private(set) var refreshToken: String

    /// The current session
    public private(set) var session: Session?

    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }

    public func startNewSession(completion: @escaping (Session?) -> Void) {
        QuestTradeAPI.getAccessToken(refreshToken: refreshToken) { [weak self] result in
            self?.handle(result: result, completion: completion)
        }
    }

    private func handle(result: GetAccessTokenResult, completion: @escaping (Session?) -> Void) {
        switch result {
        case .success(let response):
            // update refresh token
            refreshToken = response.refresh_token

            // start session
            session = Session(accessToken: response.access_token,
                                baseURLString: response.api_server,
                                tokenType: response.token_type)

        case .failure(let error):
            print(error)
        }

        completion(session)
    }
}
