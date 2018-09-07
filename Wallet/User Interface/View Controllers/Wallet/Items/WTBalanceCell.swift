//
//  WTBalanceCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTBalanceCell: UITableViewCell {
    static let reuseIdentifier: String = "WTBalanceCell"

    var titleLabel: UILabel!
    var valueLabel: UILabel!
    
    init() {
        super.init(style: .default, reuseIdentifier: WTBalanceCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.get(.main, weight: .medium, size: 13)
        titleLabel.textColor = WTColor.wt_walletTitle
        titleLabel.text = String.localized("WT.Balance.Title")
        
        valueLabel = UILabel()
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont.get(.main, weight: .medium, size: 25)
        valueLabel.textColor = WTColor.wt_walletValue

        self.addSubview(titleLabel)
        self.addSubview(valueLabel)
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
        
        titleLabel.frame = CGRect(x: paddingX, y: paddingY, width: self.frame.size.width - 2 * paddingX, height: 20)
        valueLabel.frame = CGRect(x: paddingX, y: titleLabel.frame.origin.y + titleLabel.frame.size.height, width: self.frame.size.width - 2 * paddingX, height: 40)
    }
}
