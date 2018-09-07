//
//  WTWalletServiceCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTWalletServiceCell: UICollectionViewCell {
    static let reuseIdentifier = "WTWalletServiceCell"

    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        imageView = UIImageView()
        imageView.setCorner(radius: 5)
        imageView.contentMode = .scaleAspectFit
        
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let marginX: CGFloat = 7.5
        
        imageView.frame = CGRect(x: marginX, y: marginX, width: self.frame.size.width - 2 * marginX, height: self.frame.size.height - 2 * marginX)
    }
}
