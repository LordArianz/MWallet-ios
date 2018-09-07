//
//  WTCardDetailedCell.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class WTCardCozyCell: UITableViewCell {
    static let reuseIdentifier: String = "WTCardCozyCell"
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    var rootView: UIView!
    var valueLabel: UILabel!
    var numLabel: UILabel!
    var bankLogo: UIImageView!
    
    var style: WTBankCardStyleType {
        didSet { setStyle() }
    }
    
    func setStyle(){
        let styleVar: WTBankCardStyle = WTBankCardStyles[style]!
        gradientLayer.colors = [UIColor(styleVar.left).cgColor, UIColor(styleVar.right).cgColor]
        let iconName: String = "icon-bank-card-\(style.rawValue)"
        print(iconName)
        bankLogo.image = UIImage(named: iconName)
    }
    
    init(_ style: WTBankCardStyleType) {
        self.style = style
        super.init(style: .default, reuseIdentifier: WTCardCozyCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.locations = [0, 1]
        
        rootView = UIView()
        rootView.layer.addSublayer(gradientLayer)
        rootView.layer.masksToBounds = true
        rootView.setCorner(radius: 8)
        rootView.setShadow(10, offset: CGSize(width: 0, height: 1), color: WTColor.wt_CardShadow, alpha: 1.0)
        
        bankLogo = UIImageView()
        bankLogo.contentMode = .scaleAspectFit
        
        valueLabel = UILabel()
        valueLabel.textColor = WTColor.wt_DarkCardText
        valueLabel.font = UIFont.get(.mainFaNum, weight: .medium, size: 20)
        valueLabel.textAlignment = .right
        
        numLabel = UILabel()
        numLabel.textColor = WTColor.wt_DarkCardText
        numLabel.font = UIFont.get(.mainFaNum, weight: .regular, size: 20)
        numLabel.textAlignment = .right
        
        rootView.addSubview(bankLogo)
        rootView.addSubview(numLabel)
        rootView.addSubview(valueLabel)
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
        gradientLayer.frame = rootView.bounds
        valueLabel.sizeToFit()
        valueLabel.center.y = rootView.frame.size.height / 2
        valueLabel.frame.origin.x = rootView.frame.size.width - paddingX - valueLabel.frame.size.width
        numLabel.sizeToFit()
        numLabel.frame = CGRect(x: paddingX, y: rootView.frame.size.height - numLabel.frame.size.height - 10, width: rootView.frame.size.width - 2 * paddingX, height: numLabel.frame.size.height)
        let imageSide: CGFloat = 30
        bankLogo.frame = CGRect(x: rootView.frame.size.width - paddingX - imageSide, y: paddingX, width: imageSide, height: imageSide)
    }

}

