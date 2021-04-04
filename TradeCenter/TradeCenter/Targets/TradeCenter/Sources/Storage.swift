//
//  Storage.swift
//  TradeCenter
//
//  Created by Jeremie Benhamron on 2021-04-03.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

class Storage {
    private enum Key: String {
        case refreshToken
    }

    private let userDefaults = UserDefaults.standard

    static let shared: Storage = Storage()

    var refreshToken: String? {
        get {
            return userDefaults.string(forKey: Key.refreshToken.rawValue)
        }

        set {
            userDefaults.set(newValue, forKey: Key.refreshToken.rawValue)
        }
    }
}
