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
    let innerView: UIView = UIView()
    let titleLabel: UILabel = UILabel()
    let detailLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    init() {
        super.init(style: .default, reuseIdentifier: WTBalanceCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear

        rootView = UIView()
        rootView.backgroundColor = WTColor.wt_DarkCardText
        rootView.setCorner(radius: 4)
        rootView.clipsToBounds = true
        rootView.layer.masksToBounds = true
        rootView.setShadow(2, offset: CGSize(width: 0, height: 1), color: WTColor.wt_black, alpha: 0.15)
        tagLayer.backgroundColor = UIColor.red.cgColor
        
        innerView.backgroundColor = UIColor.clear
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.get(.main, weight: .medium, size: 15)
        titleLabel.textColor = WTColor.wt_walletValue

        detailLabel.textAlignment = .right
        detailLabel.font = UIFont.get(.main, weight: .regular, size: 13)
        detailLabel.textColor = WTColor.wt_walletTitle

        valueLabel.textAlignment = .left
        valueLabel.font = UIFont.get(.main, weight: .medium, size: 15)
        valueLabel.textColor = WTColor.wt_factorValue

        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.get(.main, weight: .regular, size: 14)
        dateLabel.textColor = WTColor.wt_walletTitle

        innerView.addSubview(titleLabel)
        innerView.addSubview(detailLabel)
        innerView.addSubview(valueLabel)
        innerView.addSubview(dateLabel)
        rootView.addSubview(innerView)
        self.addSubview(rootView)
//        rootView.layer.addSublayer(tagLayer)
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
        let paddingX: CGFloat = 20
        let paddingY: CGFloat = 10
        
        rootView.frame = CGRect(x: marginX, y: marginY, width: self.frame.size.width - 2 * marginX, height: self.frame.size.height - 2 * marginY)
        tagLayer.frame = CGRect(x: rootView.frame.size.width - 5, y: 0, width: 7, height: rootView.frame.size.height)
        innerView.frame = CGRect(x: paddingX, y: paddingY, width: rootView.frame.size.width - 2 * paddingX, height: rootView.frame.size.height - 2 * paddingY)
        
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: innerView.frame.size.width / 2, y: 0, width: innerView.frame.size.width / 2, height: titleLabel.frame.size.height)
        detailLabel.sizeToFit()
        detailLabel.frame = CGRect(x: innerView.frame.size.width / 2, y: innerView.frame.size.height - detailLabel.frame.size.height, width: innerView.frame.size.width / 2, height: detailLabel.frame.size.height)
        valueLabel.sizeToFit()
        valueLabel.frame = CGRect(x: 0, y: 0, width: innerView.frame.size.width / 2, height: valueLabel.frame.size.height)
        dateLabel.sizeToFit()
        dateLabel.frame = CGRect(x: 0, y: innerView.frame.size.height - dateLabel.frame.size.height, width: innerView.frame.size.width / 2, height: dateLabel.frame.size.height)
    }
}
