//
//  ViewController.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-03-14.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Cocoa
import QuestTradeKit

class ViewController: NSViewController {
    var currentSession: Session? {
        sessionManager?.session
    }
    
    var sessionManager: SessionManager?

    let manuallyGeneratedRefreshToken = "7vohv-B9br3Zl8FlO-t-djnjnosBGy2k0"

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshToken = Storage.shared.refreshToken ?? manuallyGeneratedRefreshToken
        //let refreshToken = manuallyGeneratedRefreshToken

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

    private func didGet(accounts: [Account]) {
        let startTime = "2021-04-02T00:00:00+00:00"
        let endTime = "2021-04-25T00:00:00+00:00"

//        for account in accounts {
//            getExecutions(for: account, startTime: startTime, endTime: endTime)
//        }

//        for account in accounts {
//            getActivities(for: account, startTime: startTime, endTime: endTime)
//        }

        for account in accounts {
            getOrders(for: account, startTime: startTime, endTime: endTime, filter: .All)
        }
    }

    private func getExecutions(for account: Account, startTime: String, endTime: String) {
        currentSession?.getAccountExecutions(accountNumber: account.number, startTime: startTime, endTime: endTime) { result in
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

    private func getActivities(for account: Account, startTime: String, endTime: String) {
        currentSession?.getAccountActivities(accountNumber: account.number, startTime: startTime, endTime: endTime) { result in
            switch result {
            case .success(let response):
                print("activities count: \(response.activities.count)")
                for activity in response.activities {
                    print("account: \(account.number) -  activity: \(activity.action)")
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }

    private func getOrders(for account: Account,
                           startTime: String,
                           endTime: String,
                           filter: OrderStateFilterType) {
        currentSession?.getAccountOrders(accountNumber: account.number, startTime: startTime, endTime: endTime, filter: filter) { result in
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
}

