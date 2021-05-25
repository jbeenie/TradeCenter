//
//  Portfolio.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public struct Portfolio {
    public let accounts: [Account]

    public init(accounts: [Account]) {
        self.accounts = accounts
    }
}
