//
//  WTCardPreviewCell.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

struct WTCardPreviewValues {
    let cardNumber: String
    let expDate: String
    let cvv2: String
    var type: WTBankCardStyleType {
        let num = cardNumber.replacingOccurrences(of: " ", with: "")
        for (key, value) in WTBankCardStyles {
            if num.starts(with: value.code) {
                return key
            }
        }
        return .none
    }
}

class WTCardPreviewCell: UITableViewCell {
    
    let gradientLayer: CAGradientLayer = CAGradientLayer()

    let name: UILabel = UILabel()
    let logo: UIImageView = UIImageView()
    
    let cvv2Title: UILabel = UILabel()
    let cvv2Value: UILabel = UILabel()
    
    let expDateTitle: UILabel = UILabel()
    let expDateValue: UILabel = UILabel()
    
    let cardNo: UILabel = UILabel()
    
    var values: WTCardPreviewValues =
        WTCardPreviewValues(cardNumber: "XXXX     XXXX     XXXX     XXXX",
                            expDate: "-/-", cvv2: "-")
    
    func bankTypeSet(){
        let style: WTBankCardStyle = WTBankCardStyles[values.type]!
        self.gradientLayer.colors = [ UIColor(style.left).cgColor, UIColor(style.right).cgColor ]
        UIView.animate(withDuration: 0.1) { [unowned self] () in
            if self.values.type == .none {
                self.logo.alpha = 0
                self.name.alpha = 0
            } else {
                self.logo.alpha = 1
                self.name.alpha = 1
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layer.addSublayer(gradientLayer)
        self.addSubview(name)
        self.addSubview(logo)
        self.addSubview(cardNo)
        self.addSubview(expDateTitle)
        self.addSubview(expDateValue)
        self.addSubview(cvv2Title)
        self.addSubview(cvv2Value)
        
        cvv2Title.alpha = 0.5
        expDateTitle.alpha = 0.5
        gradientLayer.cornerRadius = 5
        
        expDateTitle.font = UIFont.get(.mainFaNum, weight: .medium, size: 11)
        cvv2Title.font = expDateTitle.font
        
        name.font = UIFont.get(.mainFaNum, weight: .medium, size: 14)
        expDateValue.font = name.font
        cvv2Value.font = name.font
        
        cardNo.font = UIFont.get(.main, weight: .medium, size: 18)
        
    }
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 20, y: 20,
                                     width: self.frame.size.width - 40,
                                     height: self.frame.size.height - 30)
        logo.frame.size = CGSize(width: 30, height: 30)
        name.sizeToFit()
        cardNo.sizeToFit()
        expDateValue.sizeToFit()
        expDateTitle.sizeToFit()
        cvv2Value.sizeToFit()
        cvv2Title.sizeToFit()
        name.center = CGPoint(x: 20 + gradientLayer.frame.size.width / 2, y: 20 + gradientLayer.frame.size.height / 2)
    }
    
}
