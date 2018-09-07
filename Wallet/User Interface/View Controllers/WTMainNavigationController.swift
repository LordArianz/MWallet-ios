//
//  WTMainNavigationController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/6/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTMainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.setBackgroundImage(UIImage.with(color:
            WTColor.wt_BarBackground), for: .default)
        self.navigationBar.barStyle = .default
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.setShadow(15, color: .black, opacity: 0.05)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        
        
    }
    override convenience init(rootViewController: UIViewController) {
        self.init(nibName: nil, bundle: nil)
        self.viewControllers = [rootViewController]
    }
    convenience init() { self.init(nibName: nil, bundle: nil) }
    required convenience init?(coder aDecoder: NSCoder) { self.init(nibName: nil, bundle: nil) }
}
