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

    let manuallyGeneratedRefreshToken = "pgEhbTLVKaVvtP1HjHu_Y0j1IJ9o-S-r0"

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshToken = Storage.shared.refreshToken ?? manuallyGeneratedRefreshToken

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
        let startTime = "2021-01-01T00:00:00+00:00"
        let endTime = "2021-03-22T00:00:00+00:00"

        for account in accounts {
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
    }
}

