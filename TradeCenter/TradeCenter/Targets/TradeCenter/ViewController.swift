//
//  ViewController.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Cocoa
import QuestTradeKit
import TradeCenterModel
import QuestTradeAdaptor

class ViewController: NSViewController {
    var currentSession: Session? {
        sessionManager?.session
    }
    
    var sessionManager: SessionManager?
    var questTradeAdaptor: QuestTradeSessionAdaptor?
    var portfolioManager: PortfolioManager?

    let manuallyGeneratedRefreshToken = "a2tbwGm0MZTwXAK2ZPo2KyUJFW7QA_gq0"

    let dateFirstAccountOpened: Date = QuestTradeAPI.querryDateFormatter.date(from: "2020-03-10T00:00:00")!

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshToken = Storage.shared.refreshToken ?? manuallyGeneratedRefreshToken
//        let refreshToken = manuallyGeneratedRefreshToken

        sessionManager = SessionManager(refreshToken: refreshToken)

        sessionManager?.startNewSession { [weak self] session in
            guard let session = session else {
                print("Error: Failed to start session.")
                return
            }

            // Store the new refresh token in persistent storage
            Storage.shared.refreshToken = self?.sessionManager?.refreshToken
            self?.sesstionDidStart(session: session)
        }
    }

    private func sesstionDidStart(session: Session) {
        questTradeAdaptor = QuestTradeSessionAdaptor(session: session)
        session.getAccounts { [weak self] result in
            switch result {
            case .success(let response):
                self?.didGet(accounts: response.accounts)
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    private func didGet(accounts: [QuestTradeKit.Account]) {
        guard let questTradeAdaptor = questTradeAdaptor else {
            print("questTradeAdaptor is nil.")
            return
        }

        let portfolio = Portfolio(accounts: accounts.map { Account($0) })
        portfolioManager = PortfolioManager(portfolio: portfolio, dataSource: questTradeAdaptor)
        
        guard let startTime = QuestTradeAPI.querryDateFormatter.date(from: "2021-03-02T00:00:00"),
            let endTime = QuestTradeAPI.querryDateFormatter.date(from: "2021-08-25T00:00:00") else {
                return
        }

        let interval = DateInterval(start: startTime, end: endTime)

        for account in accounts {
//            // getExecutions(for: account, startTime: startTime, endTime: endTime)
//            // getOrders(for: account, startTime: startTime, endTime: endTime, filter: .All)
//            // getAccountBalances(for: account)
//            // getAccountPositions(for: account)
//            getActivities(for: account, startTime: startTime, endTime: endTime)
        }

        let accountManagers = portfolioManager?.accountManagers ?? [:]
        for (account, accountManager) in accountManagers {
            accountManager.getActivities(interval: interval) { activities in
                print("\n\n\n")
                print("---------- Account: \(account.number) ----------------")
                let dividends = activities.filter { $0 is Dividend }
                let deposits = activities.filter { $0 is Deposit }
                let forXs = activities.filter { $0 is ForXConversion }
                let sells = activities.filter { $0 is Sell }
                let buys = activities.filter { $0 is Buy }
                print("---------- dividends ----------------")
                for dividend in dividends {
                    print("type: \(type(of: dividend)) - date: \(dividend.date) - desc: \(dividend.description)")
                }
                print("\n")
                print("---------- deposits ----------------")
                for deposit in deposits {
                    print("type: \(type(of: deposit)) - date: \(deposit.date) - desc: \(deposit.description)")
                }
                print("\n")
                print("---------- forX ----------------")
                for forX in forXs {
                    print("type: \(type(of: forX)) - date: \(forX.date) - desc: \(forX.description)")
                }

                print("\n")
                print("---------- buys ----------------")
                for buy in buys {
                    print("type: \(type(of: buy)) - date: \(buy.date) - desc: \(buy.description)")
                }

                print("\n")
                print("---------- sells ----------------")
                for sell in sells {
                    print("type: \(type(of: sell)) - date: \(sell.date) - desc: \(sell.description)")
                }

                print("--------------------------")
                print("\n\n\n")
            }
        }
    }

    // TODO: Get rid of this method once Quest trade adaptor is implemented
    private func getExecutions(for account: QuestTradeKit.Account, interval: DateInterval) {
        currentSession?.getAccountExecutions(accountNumber: account.number, interval: interval) { result in
            switch result {
            case .success(let response):
                print("execution count: \(response.executions.count)")
                for execution in response.executions {
                    print("account: \(account.number) -  execution: \(execution.symbol)")
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    // TODO: Get rid of this method once Quest trade adaptor is implemented
    private func getActivities(for account: QuestTradeKit.Account, interval: DateInterval) {
        currentSession?.getAccountActivities(accountNumber: account.number, interval: interval) { result in
            switch result {
            case .success(let response):
                print("activities count: \(response.activities.count)")
                for activity in response.activities {
                    print("account: \(account.number) - action: \(activity.action) - type: \(activity.type) - date: \(activity.transactionDate) - desc: \(activity.description)")
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    // TODO: Get rid of this method once Quest trade adaptor is implemented
    private func getOrders(for account: QuestTradeKit.Account,
                           interval: DateInterval,
                           filter: OrderStateFilterType) {
        currentSession?.getAccountOrders(accountNumber: account.number, interval: interval, filter: filter) { result in
            switch result {
            case .success(let response):
                print("orders count: \(response.orders.count)")
                for order in response.orders {
                    print("account: \(account.number) -  order: \(order.symbol) - order type: \(order.orderType)")
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    // TODO: Get rid of this method once Quest trade adaptor is implemented
    private func getAccountBalances(for account: QuestTradeKit.Account) {
        currentSession?.getAccountBalances(accountNumber: account.number) { result in
            switch result {
            case .success(let response):
                print("perCurrencyBalances count: \(response.perCurrencyBalances.count)")
                for balances in response.perCurrencyBalances {
                    print("account: \(account.number) -  currency: \(balances.currency) - totalEquity: \(balances.totalEquity)")
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    // TODO: Get rid of this method once Quest trade adaptor is implemented
    private func getAccountPositions(for account: QuestTradeKit.Account) {
        currentSession?.getAccountPositions(accountNumber: account.number) { result in
            switch result {
            case .success(let response):
                print("positions count: \(response.positions.count)")
                for positions in response.positions {
                    print("account: \(account.number) -  symbol: \(positions.symbol) - open pnl: \(positions.openPnl)")
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

