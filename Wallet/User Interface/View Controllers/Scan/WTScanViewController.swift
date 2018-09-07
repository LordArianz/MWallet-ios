//
//  WTScanViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTScanViewController: WTViewController, UIScrollViewDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let selector: WTSelector = WTSelector()
    
    let container: UIView = UIView()
    var scrollView: UIScrollView = UIScrollView()
    var currentIndex: Int = 0 {
        didSet {
            self.scrollView.setContentOffset(CGPoint(x: self.scrollView.frame.size.width
                * CGFloat(currentIndex), y: 0), animated: true)
        }
    }
    var viewControllers: [UIViewController] = [WTQRViewController(), WTNFCViewController()] {
        didSet { setViewControllers() }
    }
    
    func setViewControllers() {
        for sub in self.scrollView.subviews {
            sub.removeFromSuperview()
        }
        for vc in self.viewControllers {
            self.scrollView.addSubview(vc.view)
        }
        viewDidLayoutSubviews()
    }
    
    override func loadView() {
        super.loadView()
        scrollView.isScrollEnabled = false
        self.view.addSubview(container)
        container.addSubview(scrollView)
        selector.items = [WTSelectorItem(image: UIImage(named: "icon-scan-qrcode")!, title: String.localized("WT.Scan.QRCode")),
                          WTSelectorItem(image: UIImage(named: "icon-scan-nfc")!, title: String.localized("WT.Scan.NFC"))]
        selector.onSelect = { [unowned self] (index) in
            print(index)
            self.currentIndex = index
        }
        self.view.addSubview(selector)
        setViewControllers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.container.frame = self.view.bounds
        self.scrollView.frame = container.bounds
        var x: CGFloat = 0
        for v in self.scrollView.subviews {
            v.frame = CGRect(x: x, y: 0,
                             width: self.scrollView.frame.size.width,
                             height: self.scrollView.frame.size.height)
            x += self.scrollView.frame.size.width
        }
        scrollView.contentOffset = CGPoint(x: self.scrollView.frame.size.width
            * CGFloat(currentIndex), y: 0)
        selector.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear par")
        viewControllers[currentIndex].viewDidAppear(animated)
        //tof
        viewControllers[1-currentIndex].viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear par")
    }
}
