//
//  WTAddCardViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTAddCardViewController: WTViewController, UITableViewDataSource {

    var rootView: UIView!
    var animating: Bool = true
    let marginTop: CGFloat = 80
    var titleLabel: UILabel!
    var cancelBtn: UIButton!
    var tableView: UITableView!
    var doneBtn: UIButton!
    var fingerPrintBtn: UIButton!
    
    override func loadView() {
        super.loadView()
        
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

        
        rootView.addSubview(titleLabel)
        rootView.addSubview(cancelBtn)
        rootView.addSubview(doneBtn)
        self.view.addSubview(rootView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView
            .dequeueReusableCell(withIdentifier:
                "CardCell-\(indexPath.section)-\(indexPath.row)")
        if cell == nil {
            
            if indexPath.section == 0 {
                
            } else { // 1
                if indexPath.row == 0 {
                    
                } else if indexPath.row == 1 {
                    
                } else { // 2
                    
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
            if location.y < marginTop {
                UIView.animate(withDuration: 0, animations: {
                    self.dismiss(animated: false, completion: nil)
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = WTColor.wt_ParentVCBackground
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
        titleLabel.sizeToFit()
        let paddingTop: CGFloat = 10
        let paddingX: CGFloat = 15
        titleLabel.frame.origin = CGPoint(x: self.view.frame.size.width - paddingX - titleLabel.frame.size.width, y: paddingTop)
        cancelBtn.frame = CGRect(x: paddingX, y: titleLabel.frame.origin.y, width: 50, height: titleLabel.frame.size.height)
        
        let doneHeight: CGFloat = 59
        
        doneBtn.frame = CGRect(x: 0, y: rootView.frame.size.height - doneHeight, width: rootView.frame.size.width, height: doneHeight)
        
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
    }
}
