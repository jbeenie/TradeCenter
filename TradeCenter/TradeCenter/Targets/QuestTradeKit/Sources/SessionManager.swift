//
//  QTSessionManager.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit

public class SessionManager {
    /// Token Generated from quest trade which is used to refresh the access Token.
    private var refreshToken = "Qo4jtHGXglqEeNQtljEBzSPJBibZZ4QE0"

    private var session: Session?

    public static let shared: SessionManager = SessionManager()

    private init() {}

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
