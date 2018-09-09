//
//  WTViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/6/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit


extension UIViewController {
    func setTitle(_ title: String) {
        let label: UILabel = UILabel()
        label.text = title
        label.font = UIFont.get(.main, weight: .medium, size: 15)
        label.textColor = WTColor.wt_RegularText
        label.sizeToFit()
        navigationItem.titleView = label
    }
}

class WTViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = String.localized("WT.Navigation.Back")
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.get(.main, weight: .medium, size: 15)], for: UIControlState.normal)
        backButton.tintColor = WTColor.wt_RegularText
        self.navigationItem.backBarButtonItem = backButton
    }
    
    private var rightItemAction: ((UIBarButtonItem) -> ())?
    func setRightItem(icon: String, _ withAction: @escaping ((UIBarButtonItem) -> ())) {
        let button: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: icon)?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(rightBarAction(_ :)))
        button.tintColor = WTColor.wt_BarItem
        self.rightItemAction = withAction
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc func rightBarAction(_ sender: UIBarButtonItem) {
        self.rightItemAction?(sender)
    }

    private var leftItemAction: ((UIBarButtonItem) -> ())?
    func setleftItem(icon: String, _ withAction: @escaping ((UIBarButtonItem) -> ())) {
        let button: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: icon)?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(leftBarAction(_ :)))
        button.tintColor = WTColor.wt_BarItem
        self.leftItemAction = withAction
        self.navigationItem.leftBarButtonItem = button
    }
    
    @objc func leftBarAction(_ sender: UIBarButtonItem) {
        self.leftItemAction?(sender)
    }

}
