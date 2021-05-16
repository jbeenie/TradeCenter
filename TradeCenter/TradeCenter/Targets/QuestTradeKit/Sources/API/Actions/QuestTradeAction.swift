//
//  QuestTradeAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-05-04.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public protocol QuestTradeAction: HttpAction {

}

extension QuestTradeAction {
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(QuestTradeAPI.responseDateFormatter)
        return decoder
    }
}
