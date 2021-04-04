//
//  QuestTradeAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public protocol AccountAction: HttpAction {
    var accessToken: String { get }
    var tokenType: String { get }
}

extension AccountAction {
    var headers: [HttpHeader] {
        return [(key: "Authorization", value: "\(tokenType) \(accessToken)")]
    }
}
