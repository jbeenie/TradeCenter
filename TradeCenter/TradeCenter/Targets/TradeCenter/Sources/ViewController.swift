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
    var currentSession: QTSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        QTSessionManager.shared.startNewSession { [weak self] in
            self?.currentSession = $0 }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

