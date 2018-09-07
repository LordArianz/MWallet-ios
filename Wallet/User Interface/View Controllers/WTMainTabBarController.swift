//
//  WTMainTabBarController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/6/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTMainTabBarController: UITabBarController {
    let customTabBar: WTTabBar = WTTabBar()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = self.tabBar.frame.size.height
        self.customTabBar.frame = CGRect(x: 0, y: self.view.frame.size.height - height, width: self.view.frame.size.width, height: height)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.view.addSubview(customTabBar)
        viewDidLayoutSubviews()
        self.tabBar.alpha = 0
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = WTColor.wt_MainBackground
        self.customTabBar.buttons = [UIImage(named: "icon-tab-profile")!,
                                     UIImage(named: "icon-tab-stocks")!,
                                     UIImage(named: "icon-tab-scan")!,
                                     UIImage(named: "icon-tab-wallet")!,
                                     UIImage(named: "icon-tab-main")!]
        self.customTabBar.notifications = [0]
        self.customTabBar.onSelect = { [unowned self] (index) in
            self.selectedIndex = index
            print("hola amigos")
        }
        self.viewControllers = [WTMainNavigationController(rootViewController: WTServiceViewController()),
                                WTMainNavigationController(),
                                WTMainNavigationController(rootViewController: WTScanViewController()),
                                WTMainNavigationController(rootViewController: WTWalletViewController()),
                                WTMainNavigationController(rootViewController: WTCardsViewController())]
    }
    convenience init() { self.init(nibName: nil, bundle: nil) }
    required convenience init?(coder aDecoder: NSCoder) { self.init(nibName: nil, bundle: nil) }
}
