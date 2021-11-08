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

    let manuallyGeneratedRefreshToken = "tC4fexNee5QQL2XmAhXx2EZ46vBdhSxr0"

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

        let portfolio = Portfolio(accounts: accounts.map { TradeCenterModel.Account($0) })
        portfolioManager = PortfolioManager(portfolio: portfolio, dataSource: questTradeAdaptor)

//        for account in accounts {
//            // getExecutions(for: account, startTime: startTime, endTime: endTime)
//            // getOrders(for: account, startTime: startTime, endTime: endTime, filter: .All)
//            // getAccountBalances(for: account)
//            // getAccountPositions(for: account)
//            getActivities(for: account, startTime: startTime, endTime: endTime)
//        }

        guard let interval = dateInterval() else {
            return
        }

        let accountManagers = portfolioManager?.accountManagers ?? [:]
        for (account, accountManager) in accountManagers.reversed() {
            accountManager.getBalances { balances in
                accountManager.getActivities(interval: interval) { activities in
                    let report = AccountReport(activities: activities, account: account, balances: balances)
                    report.printSummary()
                    report.printDetail()
                }
            }
        }
    }

    func dateInterval() -> DateInterval? {
        guard var start = QuestTradeAPI.querryDateFormatter.date(from: "2021-03-02T00:00:00"),
            var end = QuestTradeAPI.querryDateFormatter.date(from: "2021-08-25T00:00:00") else {
                return nil
        }

        start = dateFirstAccountOpened
        end = Date()


        return DateInterval(start: start, end: end)
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

