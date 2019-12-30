//
//  ItemsCell.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import UIKit
import Kingfisher

class ItemsCell: UICollectionViewCell {

    // MARK:- IBOutlet
    @IBOutlet private weak var imgItem: UIImageView!
    
    // MARK: Variables
    var item:String! {
        didSet {
            self.imgItem.kf.indicatorType = .activity
            self.imgItem.kf.setImage(with: URL(string: item))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
