//
//  WTAddCardViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTAddCardViewController: WTViewController, UITableViewDataSource, UITableViewDelegate {

    var rootView: UIView!
    var animating: Bool = true
    let marginTop: CGFloat = 80
    var titleLabel: UILabel!
    var cancelBtn: UIButton!
    var tableView: UITableView!
    var doneBtn: UIButton!
    var fingerPrintBtn: UIButton!
    
    var cardPreviewCell: WTCardPreviewCell?
    var cardNumberCell: WTCardDataInputCell?
    var cardCVV2Cell: WTCardDataInputCell?
    var cardDateCell: WTCardDataInputCell?
    
    var onChange: ((WTCardDataInputCell) -> ())?
    
    override func loadView() {
        super.loadView()
        
        self.onChange = { [unowned self] (cell) in
            if cell == self.cardDateCell {
                let month = self.cardDateCell?.fields[1].text ?? "-"
                let year = self.cardDateCell?.fields[0].text ?? "-"
                self.cardPreviewCell?.values.expDate = year.localizedFormat + "/" + month.localizedFormat
            } else if cell == self.cardCVV2Cell {
                self.cardPreviewCell?.values.cvv2
                    = (self.cardCVV2Cell?.fields[0].text ?? "-").localizedFormat
            } else if cell == self.cardNumberCell {
                let tmp1: String
                    = (self.cardNumberCell?.fields[3].text ?? "")
                        + (self.cardNumberCell?.fields[2].text ?? "")
                let tmp2: String
                    = (self.cardNumberCell?.fields[1].text ?? "")
                        + (self.cardNumberCell?.fields[0].text ?? "")
                var tmp = tmp1 + tmp2 // Swift error: Complex Expression??!!!!!!!
                if tmp.characters.count == 16 {
                    let tmp1: String
                        = (self.cardNumberCell?.fields[3].text ?? "") + "     "
                            + (self.cardNumberCell?.fields[2].text ?? "")
                    let tmp2: String
                        = (self.cardNumberCell?.fields[1].text ?? "") + "     "
                            + (self.cardNumberCell?.fields[0].text ?? "")
                    tmp = tmp1 + "     " + tmp2
                }
                self.cardPreviewCell?.values.cardNumber
                    = tmp == "" ? "XXXX     XXXX     XXXX     XXXX" : tmp.localizedFormat
            }
            print("LOL")
        }
        
        rootView = UIView()
        rootView.backgroundColor = WTColor.wt_BarBackground
        rootView.setCorner(radius: 10)
        rootView.clipsToBounds = false

        titleLabel = UILabel()
        titleLabel.textColor = WTColor.wt_CardTitle
        titleLabel.textAlignment = .right
        titleLabel.font = UIFont.get(.main, weight: .regular, size: 17)
        titleLabel.text = String.localized("WT.Card.Add.Title")
        
        cancelBtn = UIButton()
        //cancelBtn.setTitle(String.localized("WT.Card.Add.Cancel"), for: .normal)
        cancelBtn.setAttributedTitle(NSAttributedString.init(string: String.localized("WT.Card.Add.Cancel"), attributes:
            [NSAttributedStringKey.font:
                UIFont.get(.main, weight: .regular, size: 17),
             NSAttributedStringKey.foregroundColor:
                WTColor.wt_InlineButtonText]), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        doneBtn = UIButton()
        doneBtn.backgroundColor = WTColor.wt_Done
        doneBtn.setAttributedTitle(NSAttributedString.init(string: String.localized("WT.Card.Add"), attributes:
            [NSAttributedStringKey.font:
                UIFont.get(.main, weight: .bold, size: 16),
             NSAttributedStringKey.foregroundColor:
                WTColor.wt_DarkCardText]), for: .normal)
        doneBtn.addTarget(self, action: #selector(addCard(_:)), for: .touchUpInside)
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        rootView.addSubview(titleLabel)
        rootView.addSubview(cancelBtn)
        rootView.addSubview(tableView)
        rootView.addSubview(doneBtn)
        self.view.addSubview(rootView)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190 + 20
        }
        return 81
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId: String = "CardCell-\(indexPath.section)-\(indexPath.row)"
        var cell: UITableViewCell? = tableView
            .dequeueReusableCell(withIdentifier: reuseId)
        if cell == nil {
            
            if indexPath.section == 0 {
                cardPreviewCell = WTCardPreviewCell(style: .default, reuseIdentifier: reuseId)
                cell = cardPreviewCell
            } else { // 1
                if indexPath.row == 0 {
                    cardNumberCell = WTCardDataInputCell(style: .default, reuseIdentifier: reuseId)
                    cardNumberCell?.title = String.localized("WT.Card.Info.Number")
                    cardNumberCell?.inputCount = 4
                    cardNumberCell?.onChange = self.onChange
                    cardNumberCell?.onNext = { [unowned self] (field) in
                        if self.cardCVV2Cell?.fields[0].text?.characters.count == 4 {
                            field.resignFirstResponder()
                        } else {
                            self.cardCVV2Cell?.fields[0].becomeFirstResponder()
                        }
                    }
                    cell = cardNumberCell
                } else if indexPath.row == 1 {
                    cardCVV2Cell = WTCardDataInputCell(style: .default, reuseIdentifier: reuseId)
                    cardCVV2Cell?.title = String.localized("WT.Card.Info.CVV2")
                    cardCVV2Cell?.inputCount = 1
                    cardCVV2Cell?.onChange = self.onChange
                    cardCVV2Cell?.onNext = { [unowned self] (field) in
                        if self.cardDateCell?.fields[1].text?.characters.count == 2 {
                            if self.cardDateCell?.fields[0].text?.characters.count == 2 {
                                field.resignFirstResponder()
                            } else {
                                self.cardDateCell?.fields[0].becomeFirstResponder()
                            }
                        } else {
                            self.cardDateCell?.fields[1].becomeFirstResponder()
                        }
                    }
                    cardCVV2Cell?.onPrevious = { [unowned self] (field) in
                        self.cardNumberCell?.fields[0].becomeFirstResponder()
                    }
                    cell = cardCVV2Cell
                } else { // 2
                    cardDateCell = WTCardDataInputCell(style: .default, reuseIdentifier: reuseId)
                    cardDateCell?.title = String.localized("WT.Card.Info.ExpireDate")
                    cardDateCell?.inputCount = 2
                    cardDateCell?.inputLimit = 2
                    cardDateCell?.fields[0].placeholder = String.localized("WT.Card.Info.ExpireDate.Year")
                    cardDateCell?.fields[1].placeholder = String.localized("WT.Card.Info.ExpireDate.Month")
                    cardDateCell?.bottomBar.opacity = 0
                    cardDateCell?.onChange = self.onChange
                    cardDateCell?.onNext = { [unowned self] (field) in
                        field.resignFirstResponder()
                    }
                    cardDateCell?.onPrevious = { [unowned self] (field) in
                        self.cardCVV2Cell?.fields[0].becomeFirstResponder()
                    }
                    cell = cardDateCell
                }
            }
            
        }
        return cell!
    }

    @objc func addCard(_ sender: Any) {
        
    }

    @objc func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            if location.y < marginTop && !keyboardUp {
                self.cancel(self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = WTColor.wt_ParentVCBackground
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if animating {
            return
        }
        rootView.frame = CGRect(x: 0, y: marginTop, width: self.view.frame.width, height: self.view.frame.height - marginTop)
        if keyboardUp {
            rootView.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height, width: self.view.frame.width, height: self.view.frame.height - UIApplication.shared.statusBarFrame.size.height)
        }
        titleLabel.sizeToFit()
        let paddingTop: CGFloat = 10
        let paddingX: CGFloat = 15
        titleLabel.frame.origin = CGPoint(x: self.view.frame.size.width - paddingX - titleLabel.frame.size.width, y: paddingTop)
        cancelBtn.frame = CGRect(x: paddingX, y: titleLabel.frame.origin.y, width: 50, height: titleLabel.frame.size.height)
        tableView.frame.origin = CGPoint(x: 0, y: 10 + titleLabel.frame.origin.y + titleLabel.frame.size.height)
        var doneHeight: CGFloat = 59
        if #available(iOS 11.0, *) {
            doneHeight += AppDelegate.window!.safeAreaInsets.bottom
            doneBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.window!.safeAreaInsets.bottom, right: 0)
        }
        doneBtn.frame = CGRect(x: 0, y: rootView.frame.size.height - doneHeight, width: rootView.frame.size.width, height: doneHeight)
        tableView.frame.size = CGSize(width: rootView.frame.size.width, height: rootView.frame.size.height - tableView.frame.origin.y - doneHeight)
        if keyboardUp {
            tableView.frame.size.height = rootView.frame.size.height - tableView.frame.origin.y - keyboardHeight
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height - marginTop)
        UIView.animate(withDuration: 0.24, delay: 0, options: .curveEaseIn, animations: {
            self.rootView.frame.origin.y = self.marginTop
        }, completion: { [unowned self] (success) in
            self.animating = false
            self.viewDidLayoutSubviews()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAction(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAction(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    var keyboardUp: Bool = false
    var keyboardHeight: CGFloat = 0
    @objc func keyboardAction(notification: Notification) {
        print(notification.name)
        if notification.name == .UIKeyboardWillHide {
            keyboardUp = false
            keyboardHeight = 0
        } else { // show!
            keyboardUp = true
            if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
                print(keyboardHeight)
            }
        }
        viewDidLayoutSubviews()
    }
    
}
