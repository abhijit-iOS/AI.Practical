//
//  Util.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import UIKit

class Util: NSObject {
    class var isReachable: Bool {
        return Reachability.shared.connection != .none
    }
}
