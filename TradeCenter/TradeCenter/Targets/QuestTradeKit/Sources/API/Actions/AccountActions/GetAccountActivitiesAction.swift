//
//  GetAccountActivitiesAction.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import HTTPKit

public typealias GetAccountActivitiesResult = Result<GetAccountActivitiesResponse, Error>

public struct GetAccountActivitiesResponse: Decodable {
    public let activities: [Activity]
}

struct GetAccountActivitiesAction: AccountAction {
    typealias Response = GetAccountActivitiesResponse
    var path: String {
        "/v1/accounts/\(accountNumber)/activities"
    }

    let accountNumber: String
    let interval: DateInterval
    let method: HttpMethod = .get
    let accessToken: String
    let tokenType: String

    var queryItems: [URLQueryItem]? {
        let startTimeItem = URLQueryItem(name: "startTime", value: QuestTradeAPI.responseDateFormatter.string(from: interval.start))
        let endTimeItem = URLQueryItem(name: "endTime", value: QuestTradeAPI.responseDateFormatter.string(from: interval.end))
        return [startTimeItem, endTimeItem]
    }
}
