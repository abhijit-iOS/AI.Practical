//
//  Extension.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius:Double {
        get {
            return 0
        }
        set {
            if newValue > 0 {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = newValue
            }
        }
    }
    
}
