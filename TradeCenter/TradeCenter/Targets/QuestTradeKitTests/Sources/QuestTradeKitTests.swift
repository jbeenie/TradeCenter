//
//  QuestTradeKitTests.swift
//  QuestTradeKitTests
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import XCTest
@testable import QuestTradeKit

class QuestTradeKitTests: XCTestCase {

    let questTradeAPI: QuestTradeAPIInterface = QuestTradeAPI.instance

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAccessToken() throws {
        questTradeAPI.getAccessToken(completion: {_ in })
    }
}
