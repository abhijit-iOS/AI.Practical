//
//  UserFooterCell.swift
//  Practical
//
//  Created by MAC100 on 12/30/19.
//  Copyright © 2019 MAC100. All rights reserved.
//

import UIKit

class UserFooterCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK:- Custom Methods
    func startLoading() {
        indicator.startAnimating()
    }
}
