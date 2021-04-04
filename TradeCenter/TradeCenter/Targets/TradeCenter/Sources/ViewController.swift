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

    let manuallyGeneratedRefreshToken = "GSIBl7RWINwOv_TzK9CzwxU5os9KC71K0"

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
        session.getAccounts { result in
            switch result {
            case .success(let response):
                break
            case .failure(let errror):
                break
            }
        }
    }
}

