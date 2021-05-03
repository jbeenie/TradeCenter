//
//  Activities.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-02.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public protocol Activity {
    var date: Date { get }
    var currency: Currency { get }
    var amount: Double { get }
    var description: String { get }
}
