//
//  QuestTradeAPI.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public protocol QuestTradeAPIInterface {
    func getAccessToken(completion: @escaping (GetAccessTokenResult) -> Void)
}

public final class QuestTradeAPI: QuestTradeAPIInterface {
    public func getAccessToken(completion: @escaping (GetAccessTokenResult) -> Void) {
        let action = GetAccessTokenAction(refreshToken: refreshToken)
        authenticationActionHandler.run(action: action, completion: completion)
    }

    private let actionHandler = QuestTradeHttpActionHandler()
    private let authenticationActionHandler = QuestTradeAuthenticationHttpActionHandler()

    /// Token Generated from quest trade which is used to refresh the access Token.
    private let refreshToken = "ar4rYqij57-zU2hCfCaz3Hi3ygFQy63z0"

    // MARK: - Initializer

    private init() {}

    public static let instance: QuestTradeAPIInterface = QuestTradeAPI()

    // MARK: - Interface
}
