//
//  User.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: JSONable {
    var name :String!
    var image:String!
    var items:[String]!
    
    required init?(parameter: JSON) {
        name  = parameter["name"].stringValue
        image = parameter["image"].stringValue
        items = parameter["items"].arrayValue.map({$0.stringValue})
    }
}
