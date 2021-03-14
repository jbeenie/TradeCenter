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

}

public final class QuestTradeAPI: QuestTradeAPIInterface {
    private let actionHandler = QuestTradeHttpActionHandler()
    private let authenticationActionHandler = QuestTradeAuthenticationHttpActionHandler()

    /// Token Generated from quest trade which enables API access.
    private let authToken = "ar4rYqij57-zU2hCfCaz3Hi3ygFQy63z0"

    // MARK: - Initializer

    public init() {}

    // MARK: - Interface
}
