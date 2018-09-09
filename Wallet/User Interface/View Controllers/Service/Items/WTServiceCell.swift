//
//  WTServiceCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/8/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTServiceCell: UICollectionViewCell {
    static let reuseIdentifier = "WTServiceCell"

    let rootView: UIView = UIView()
    let titleLabel: UILabel = UILabel()
    let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        rootView.backgroundColor = WTColor.wt_DarkCardText
        rootView.setShadow(5, offset: CGSize(width: 0, height: 1), color: WTColor.wt_TabDeselectedTranslucent, alpha: 0.08)
        rootView.setCorner(radius: 35)
        
        titleLabel.font = UIFont.get(.main, weight: .medium, size: 14)
        titleLabel.textColor = WTColor.wt_walletValue
        titleLabel.textAlignment = .center
        
        imageView.contentMode = .center
        
        rootView.addSubview(imageView)
        rootView.addSubview(titleLabel)
        self.addSubview(rootView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let side: CGFloat = 110
        rootView.frame = CGRect(x: (self.frame.size.width - side) / 2, y: (self.frame.size.height - side) / 2, width: side, height: side)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 10, y: rootView.frame.size.height - 15 - titleLabel.frame.size.height, width: rootView.frame.size.width - 20, height: titleLabel.frame.size.height)
        imageView.frame = CGRect(x: 25, y: 10, width: rootView.frame.size.width - 50, height: titleLabel.frame.origin.y - 20)
    }
}
