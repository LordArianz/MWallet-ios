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
    var isRight: Bool = false
    
    convenience init(frame: CGRect, isRight: Bool) {
        self.init(frame: frame)
        self.isRight = isRight
        print("isRight")
        print(isRight)
        layoutSubviews()
    }
    
    func setIsRight(_ isRight: Bool) {
        self.isRight = isRight
        layoutSubviews()
    }
    
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
        let marginRight: CGFloat = self.frame.size.width * (isRight ? 0.104 : 0.038)
        let marginLeft: CGFloat = self.frame.size.width * (isRight ? 0.038 : 0.104)
        let marginY: CGFloat = self.frame.size.width * 0.038
        
        imageView.frame = CGRect(x: marginLeft, y: marginY, width: self.frame.size.width - marginLeft - marginRight, height: self.frame.size.height - 2 * marginY)
    }
}
