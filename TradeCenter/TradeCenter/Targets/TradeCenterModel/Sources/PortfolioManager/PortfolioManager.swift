//
//  PortfolioManager.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public class PortfolioManager {
    public private(set) var accountManagers: [Account: AccountManager]

    public init(portfolio: Portfolio, dataSource: AccountManagerDataSource) {
        self.accountManagers = [:]

        for account in portfolio.accounts {
            self.accountManagers[account] = AccountManager(account: account, dataSource: dataSource)
        }
    }
}
