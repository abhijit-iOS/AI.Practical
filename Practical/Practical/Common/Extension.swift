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
    
    @IBInspectable var cornerRadius:CGFloat {
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

extension UIViewController {
    func showAlert(message:String)  {
        let alertController = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
