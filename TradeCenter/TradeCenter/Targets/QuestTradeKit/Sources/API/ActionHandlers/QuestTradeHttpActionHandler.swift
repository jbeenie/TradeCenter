// Copyright © 2021 JABT. All rights reserved.

import Foundation
import HTTPKit

class QuestTradeHttpActionHandler: HttpActionHandler {

    private struct Constants {
        private static let baseURLString = "https://api07.iq.questrade.com"
        static let baseUrl = URL(string: baseURLString)!
    }

    // MARK: Init

    init() {
        super.init(baseUrl: Constants.baseUrl)
    }
}
