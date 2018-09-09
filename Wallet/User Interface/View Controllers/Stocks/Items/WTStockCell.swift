//
//  WTStockCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/9/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

enum WTStockChangeType {
    case positive
    case negative
    case zero
}

class WTStockCell: UITableViewCell {
    static let reuseIdentifier: String = "WTStockCell"

    let rootView: UIView = UIView()
    let seperatorView: UIView = UIView()
    let titleLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    let changeLabel: UILabel = UILabel()
    let idkLabel: UILabel = UILabel()
    var changeType: WTStockChangeType!
    
    init(_ changeType: WTStockChangeType) {
        super.init(style: .default, reuseIdentifier: WTStockCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        self.changeType = changeType
        seperatorView.backgroundColor = WTColor.wt_stocksSeperator
        titleLabel.textColor = WTColor.wt_black
        titleLabel.font = UIFont.get(.main, weight: .regular, size: 16)
        titleLabel.textAlignment = .left
        
        valueLabel.textColor = WTColor.wt_black
        valueLabel.font = UIFont.get(.mainFaNum, weight: .light, size: 16)
        valueLabel.textAlignment = .right

        switch changeType {
        case .positive:
            changeLabel.textColor = WTColor.wt_stockPositive
        case .negative:
            changeLabel.textColor = WTColor.wt_stockNegative
        default:
            changeLabel.textColor = WTColor.wt_black
        }
        changeLabel.font = UIFont.get(.mainFaNum, weight: .regular, size: 16)
        changeLabel.textAlignment = .right

        idkLabel.textColor = WTColor.wt_stock
        idkLabel.font = UIFont.get(.mainFaNum, weight: .regular, size: 13)
        idkLabel.textAlignment = .right

        rootView.addSubview(titleLabel)
        rootView.addSubview(valueLabel)
        rootView.addSubview(changeLabel)
        rootView.addSubview(idkLabel)
        rootView.addSubview(seperatorView)
        self.addSubview(rootView)
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
        let paddingX: CGFloat = 20
        rootView.frame = CGRect(x: paddingX, y: 0, width: self.frame.size.width - 2 * paddingX, height: self.frame.size.height)
        seperatorView.frame = CGRect(x: 0, y: rootView.frame.size.height - 1, width: rootView.frame.size.width, height: 1)
        valueLabel.sizeToFit()
        valueLabel.frame = CGRect(x: rootView.frame.size.width - 2 * 80, y: 0, width: 80, height: valueLabel.frame.size.height)
        valueLabel.center.y = rootView.center.y
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: 0, y: 0, width: valueLabel.frame.origin.x - 10, height: titleLabel.frame.size.height)
        titleLabel.center.y = rootView.center.y
        changeLabel.sizeToFit()
        changeLabel.frame = CGRect(x: valueLabel.frame.size.width + valueLabel.frame.origin.x, y: 7, width: 80, height: changeLabel.frame.size.height)
        idkLabel.sizeToFit()
        idkLabel.frame = CGRect(x: changeLabel.frame.origin.x, y: rootView.frame.size.height - 7 - idkLabel.frame.size.height, width: changeLabel.frame.size.width, height: idkLabel.frame.size.height)
    }
}
