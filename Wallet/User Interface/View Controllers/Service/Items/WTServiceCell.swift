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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        rootView.backgroundColor = UIColor.black
        self.addSubview(rootView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let side: CGFloat = 110
        rootView.frame = CGRect(x: (self.frame.size.width - side) / 2, y: (self.frame.size.height - side) / 2, width: side, height: side)
        print("DDDDDD")
        print(rootView.frame)
    }
}
