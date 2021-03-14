// Copyright © 2021 JABT. All rights reserved.

import Foundation

public extension Result {

    var isSuccess: Bool {
        if case .success = self {
            return true
        } else {
            return false
        }
    }
}
