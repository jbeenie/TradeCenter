//
//  QTSessionManager.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit

public class QTSessionManager {
    /// Token Generated from quest trade which is used to refresh the access Token.
    private var refreshToken = "Qo4jtHGXglqEeNQtljEBzSPJBibZZ4QE0"

    private var session: QTSession?

    public static let shared: QTSessionManager = QTSessionManager()

    private init() {}

    public func startNewSession(completion: @escaping (QTSession?) -> Void) {
        QuestTradeAPI.getAccessToken(refreshToken: refreshToken) { [weak self] result in
            self?.handle(result: result, completion: completion)
        }
    }

    private func handle(result: GetAccessTokenResult, completion: @escaping (QTSession?) -> Void) {
        switch result {
        case .success(let response):
            // update refresh token
            refreshToken = response.refresh_token

            // start session
            session = QTSession(accessToken: response.access_token,
                                baseURLString: response.api_server,
                                tokenType: response.token_type)

        case .failure(let error):
            print(error)
        }

        completion(session)
    }
}
