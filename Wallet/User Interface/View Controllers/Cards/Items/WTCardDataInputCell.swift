//
//  WTCardDataInputCell.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTCardDataInputCell: UITableViewCell {
    let title: UILabel = UILabel()
    let bottomBar: CALayer = CALayer()
    let inputContainer: UIView = UIView()
    var fields: [UITextField]
        = [UITextField(), UITextField(), UITextField(), UITextField()]
    
    var inputCount: Int = 4 {
        didSet { setInputs() }
    }
    var inputLimit: Int = 4 {
        didSet { setLimits() }
    }
    var currentValues: [String] = ["1234", "5678", "9012", "3456"]
    
    func setLimits() {
        
    }
    func setInputs() {
        for item in inputContainer.subviews {
            item.removeFromSuperview()
        }
        currentValues.removeAll(keepingCapacity: true)
        fields.removeAll(keepingCapacity: true)
        for i in 0..<inputCount {
            currentValues.append("")
            let field: UITextField = UITextField()
            field.textAlignment = .center
            fields.append(field)
            inputContainer.addSubview(field)
        }
    }
    func setValues() {
        for item in fields {
            
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.addSubview(inputContainer)
        self.addSubview(title)
        self.layer.addSublayer(bottomBar)
    }
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    override func layoutSubviews() {
        CALayer.performWithoutAnimation { [unowned self] () in
            
        }
    }

}
