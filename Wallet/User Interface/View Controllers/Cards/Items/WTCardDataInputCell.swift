//
//  WTCardDataInputCell.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTCardDataInputCell: UITableViewCell, UITextFieldDelegate {
    
    var onChange: ((WTCardDataInputCell) -> ())?
    var onPrevious: ((UITextField) -> ())?
    var onNext: ((UITextField) -> ())?
    
    let titleLabel: UILabel = UILabel()
    let bottomBar: CALayer = CALayer()
    let inputContainer: UIView = UIView()
    var fields: [UITextField]
        = [UITextField(), UITextField(), UITextField(), UITextField()]
    
    var title: String = "" {
        didSet { setTitle() }
    }
    var inputCount: Int = 4 {
        didSet { setInputs() }
    }
    var inputLimit: Int = 4 {
        didSet { setLimits() }
    }
    var currentValues: [String] = ["1234", "5678", "9012", "3456"]
    
    func setTitle() {
        titleLabel.text = title
        layoutSubviews()
    }
    func setLimits() {
        for field in fields {
        }
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
            field.textColor = WTColor.wt_CardTitle
            field.backgroundColor = WTColor.wt_InputBg
            field.setBorder(1, color: WTColor.wt_InputBorder)
            field.setCorner(radius: 5)
            field.delegate = self
            field.keyboardType = .numberPad
            field.returnKeyType = .done
            field.addTarget(self, action: #selector(fieldReturnPressed(_:)), for: .editingDidEndOnExit)
            field.font = UIFont.get(.mainFaNum, weight: .medium, size: 15)
            fields.append(field)
            inputContainer.addSubview(field)
        }
        setLimits()
    }
    func setValues() {
    
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.addSubview(inputContainer)
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.get(.main, weight: .regular, size: 13)
        self.layer.addSublayer(bottomBar)
        bottomBar.backgroundColor = WTColor.wt_TableSeperator.cgColor
        inputCount = 1
        setInputs()
        setValues()
    }
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("sag")
        let result = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if result.isNumeric && result.characters.count <= inputLimit {
            if result.characters.count == inputLimit {
                let index = self.fields.index(of: textField)! - 1
                if index >= 0 {
                    self.fields[index].becomeFirstResponder()
                } else {
                    onNext?(textField)
                }
            }
            if result.characters.count == 0 && textField.text!.characters.count >= 0 {
                let index = self.fields.index(of: textField)! + 1
                if index < fields.count {
                    self.fields[index].becomeFirstResponder()
                } else {
                    onPrevious?(textField)
                }
            }
            textField.text = result
        } /*else if result.characters.count > inputLimit {
            let index = self.fields.index(of: textField)! - 1
            if index >= 0 {
                self.fields[index].becomeFirstResponder()
            } else {
                onNext?(textField)
            }
        }*/
        onChange?(self)
        return false
        
        
    }
    @objc func fieldReturnPressed(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    override func layoutSubviews() {
        CALayer.performWithoutAnimation { [unowned self] () in
            bottomBar.frame = CGRect(x: 20, y: self.frame.size.height - 1,
                                     width: self.frame.size.width - 20 * 2, height: 1)
        }
        inputContainer.frame = self.bounds
        let inputWidth: CGFloat = (self.frame.size.width - 40 - 54) / 4
        let margin: CGFloat = 18
        var x = self.frame.size.width - 20 - inputWidth
        for input in fields {
            input.frame.size = CGSize(width: inputWidth, height: 30)
            input.frame.origin = CGPoint(x: x, y: 41)
            x -= (margin + inputWidth)
        }
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: self.frame.size.width - 20 - titleLabel.frame.size.width, y: 10)
    }

}
