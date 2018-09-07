//
//  WTCardCompactCell.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTCardCompactCell: UITableViewCell {

    static let reuseIdentifier: String = "WTCardCompactCell"
    
    var rootView: UIView!
    var valueLabel: UILabel!
    var numLabel: UILabel!
    var bankLogo: UIImageView!
    var moreButton: UIButton!
    
    var style: WTBankCardStyleType {
        didSet { setStyle() }
    }
    
    func setStyle(){
        let iconName: String = "icon-bank-card-\(style.rawValue)"
        bankLogo.image = UIImage(named: iconName)
    }

    init(_ style: WTBankCardStyleType) {
        self.style = style
        super.init(style: .default, reuseIdentifier: WTCardCozyCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        rootView = UIView()
        rootView.backgroundColor = WTColor.wt_BarBackground
        rootView.setCorner(radius: 4)
        rootView.setShadow(10, offset: CGSize(width: 0, height: 1), color: WTColor.wt_CardShadow, alpha: 1.0)

        bankLogo = UIImageView()
        bankLogo.contentMode = .scaleAspectFit
        
        numLabel = UILabel()
        numLabel.textColor = WTColor.wt_RegularText
        numLabel.font = UIFont.get(.mainFaNum, weight: .medium, size: 14)
        
        rootView.addSubview(numLabel)
        rootView.addSubview(bankLogo)
        self.addSubview(rootView)
        setStyle()
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
        let paddingY: CGFloat = 7.5
        rootView.frame = CGRect(x: paddingX, y: paddingY, width: self.frame.size.width - 2 * paddingX, height: self.frame.size.height - 2 * paddingY)
        let imageSide: CGFloat = 30
        bankLogo.frame = CGRect(x: rootView.frame.size.width - imageSide - paddingX, y: 0, width: imageSide, height: imageSide)
        bankLogo.center.y = rootView.frame.size.height / 2
        numLabel.sizeToFit()
        numLabel.center = CGPoint(x: rootView.frame.size.width / 2,
                                  y: rootView.frame.size.height / 2)
    }
}
