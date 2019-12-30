//
//  UserHeaderCell.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import UIKit
import Kingfisher

class UserHeaderCell: UICollectionViewCell {

    // MARK:- IBOutlet
    @IBOutlet private weak var imgUser: UIImageView!
    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var imgSeparator: UIImageView!
    
    // MARK: Variables
    var user:User! {
        didSet {
            self.imgUser.kf.indicatorType = .activity
            self.imgUser.kf.setImage(with: URL(string: user.image))
            self.lblUserName.text = user.name
            self.imgSeparator.isHidden = self.tag == 0 ? true : false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
