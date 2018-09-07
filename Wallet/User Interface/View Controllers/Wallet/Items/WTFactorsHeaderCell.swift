//
//  WTFactorsHeaderCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTFactorsHeaderCell: UITableViewCell {
    static let reuseIdentifier: String = "WTFactorsHeaderCell"
    
    var titleLabel: UILabel!
    var showMoreBtn: UIButton!
    
    init() {
        super.init(style: .default, reuseIdentifier: WTBalanceCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.get(.main, weight: .bold, size: 17)
        titleLabel.textColor = WTColor.wt_walletValue
        titleLabel.text = String.localized("WT.Factors.Title")
        
        showMoreBtn = UIButton()
        showMoreBtn.setAttributedTitle(NSAttributedString.init(string: String.localized("WT.Factors.Show.More"), attributes:
            [NSAttributedStringKey.font:
                UIFont.get(.main, weight: .regular, size: 17),
             NSAttributedStringKey.foregroundColor:
                WTColor.wt_InlineButtonText]), for: .normal)
        //showMoreBtn.addTarget(self, action: #selector(showMore(_:)), for: .touchUpInside)

        self.addSubview(showMoreBtn)
        self.addSubview(titleLabel)
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
        let paddingY: CGFloat = 10
        let paddingX: CGFloat = 20
        showMoreBtn.sizeToFit()
        showMoreBtn.frame = CGRect(x: paddingX, y: paddingY, width: showMoreBtn.frame.size.width, height: 30)
        titleLabel.frame = CGRect(x: showMoreBtn.frame.origin.x + showMoreBtn.frame.size.width, y: paddingY, width: self.frame.size.width - paddingX - showMoreBtn.frame.origin.x - showMoreBtn.frame.size.width, height: 30)
    }

}
