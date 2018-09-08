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
    var cardNumber: String
    var expDate: String
    var cvv2: String
    var type: WTBankCardStyleType {
        let num = cardNumber.replacingOccurrences(of: " ", with: "")
        for (key, value) in WTBankCardStyles {
            print(num)
            print(value.code)
            if num.starts(with: value.code.localizedFormat) {
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
                            expDate: "-/-", cvv2: "-") {
        didSet {bankTypeSet()}
    }
    
    func bankTypeSet(){
        let style: WTBankCardStyle = WTBankCardStyles[values.type]!
        self.gradientLayer.colors = [ UIColor(style.left).cgColor, UIColor(style.right).cgColor ]
        UIView.animate(withDuration: 0.1) { [unowned self] () in
            if self.values.type == .none {
                print("NONE?")
                self.logo.alpha = 0
                self.name.alpha = 0
            } else {
                print("NONE!")
                self.logo.alpha = 1
                self.name.alpha = 1
            }
        }
        self.cardNo.text = values.cardNumber.localizedFormat
        self.cvv2Value.text = values.cvv2.localizedFormat
        self.expDateValue.text = values.expDate.localizedFormat
        self.name.text = String.localized("WT.Card.BankName.Base") + " " + String.localized("WT.Card.BankName." + values.type.rawValue)
        self.logo.image =
            UIImage(named: "icon-bank-card-\(values.type.rawValue)")?
                .withRenderingMode(.alwaysTemplate)
        layoutSubviews()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        cvv2Title.alpha = 0.5
        expDateTitle.alpha = 0.5
        gradientLayer.cornerRadius = 5
        
        expDateTitle.font = UIFont.get(.mainFaNum, weight: .medium, size: 11)
        cvv2Title.font = expDateTitle.font
        
        name.font = UIFont.get(.mainFaNum, weight: .medium, size: 14)
        expDateValue.font = name.font
        cvv2Value.font = name.font
        
        cardNo.font = UIFont.get(.main, weight: .medium, size: 18)
        
        cvv2Title.text = String.localized("WT.Card.Detail.CVV2")
        expDateTitle.text = String.localized("WT.Card.Detail.ExpireDate")
        
        name.textColor = WTColor.wt_DarkCardText
        expDateTitle.textColor = name.textColor
        cvv2Title.textColor = name.textColor
        expDateValue.textColor = name.textColor
        cvv2Value.textColor = name.textColor
        cardNo.textColor = name.textColor
        logo.tintColor = name.textColor
        
        self.layer.addSublayer(gradientLayer)
        self.addSubview(name)
        self.addSubview(logo)
        self.addSubview(cardNo)
        self.addSubview(expDateTitle)
        self.addSubview(expDateValue)
        self.addSubview(cvv2Title)
        self.addSubview(cvv2Value)
        
        bankTypeSet()
    }
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CALayer.performWithoutAnimation { [unowned self] () in
            self.gradientLayer.frame =
                CGRect(x: 20, y: 10,
                       width: self.frame.size.width - 40,
                       height: self.frame.size.height - 20)
        }
        logo.frame.size = CGSize(width: 30, height: 30)
        name.sizeToFit()
        cardNo.sizeToFit()
        expDateValue.sizeToFit()
        expDateTitle.sizeToFit()
        cvv2Value.sizeToFit()
        cvv2Title.sizeToFit()
        cardNo.center = CGPoint(x: 20 + gradientLayer.frame.size.width / 2, y: 10 + gradientLayer.frame.size.height / 2)
        logo.frame.origin = CGPoint(x: gradientLayer.frame.size.width + 20 - 18 - logo.frame.size.width,
                                    y: 20 + 10)
        name.center.y = logo.center.y
        name.frame.origin.x = logo.frame.origin.x - 14.5 - name.frame.size.width
        let bottom: CGFloat = gradientLayer.frame.size.height + 10
        cvv2Title.frame.origin = CGPoint(x: 20 + 31, y: bottom - 20 - cvv2Title.frame.size.height)
        cvv2Value.center.y = cvv2Title.center.y
        cvv2Value.frame.origin.x = cvv2Title.frame.origin.x + cvv2Title.frame.size.width + 5
        expDateTitle.center.y = cvv2Title.center.y
        expDateTitle.frame.origin.x = gradientLayer.frame.size.width + 20 - 31 - expDateTitle.frame.size.width
        expDateValue.center.y = cvv2Title.center.y
        expDateValue.frame.origin.x = expDateTitle.frame.origin.x - expDateValue.frame.size.width - 2
    }
    
}
