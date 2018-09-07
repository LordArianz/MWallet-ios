//
//  WTNFCViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTNFCViewController: WTViewController {

    var imageView: UIImageView!
    var descLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named:"icon-scan-nfc-help")
        
        descLabel = UILabel()
        descLabel.numberOfLines = 0
        descLabel.textColor = WTColor.wt_CardTitle
        descLabel.font = UIFont.get(.main, weight: .regular, size: 16)
        descLabel.textAlignment = .center
        descLabel.text = String.localized("WT.Scan.NFC.Text")
        
        self.view.addSubview(descLabel)
        self.view.addSubview(imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: self.view.frame.size.width * 0.3, y: 0, width: self.view.frame.size.width * 0.6, height: self.view.frame.size.width * 0.5)
        imageView.center.y = self.view.center.y
        descLabel.sizeToFit()
        descLabel.frame = CGRect(x: self.view.frame.size.width * 0.1, y: imageView.frame.size.height + imageView.frame.origin.y + 50, width: self.view.frame.size.width * 0.8, height: descLabel.frame.size.height)
    }
}
