//
//  WTSimpleFactorCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTSimpleFactorCell: UITableViewCell {
    static let reuseIdentifier: String = "WTSimpleFactorCell"
    
    var rootView: UIView!
    let tagLayer: CALayer = CALayer()
    
    init() {
        super.init(style: .default, reuseIdentifier: WTBalanceCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear

        rootView = UIView()
        rootView.backgroundColor = WTColor.wt_DarkCardText
        rootView.setCorner(radius: 4)
        rootView.clipsToBounds = true
        rootView.layer.masksToBounds = true
        
        
        
        
        self.addSubview(rootView)
        rootView.layer.addSublayer(tagLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let marginX: CGFloat = 20
        let marginY: CGFloat = 5
        
        rootView.frame = CGRect(x: marginX, y: marginY, width: self.frame.size.width - 2 * marginX, height: self.frame.size.height - 2 * marginY)
        
    }
}
