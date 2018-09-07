//
//  WTProfileViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTServiceViewController: WTViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var services: [String]?
    
    override func loadView() {
        super.loadView()
        
        collectionView = UICollectionView()
        collectionView.register(self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(String.localized("WT.Tab.Wallet"))
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
