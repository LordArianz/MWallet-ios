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
    var layout: UICollectionViewFlowLayout!
    var services: [String]?
    var icons: [String]?
    var titles: [String]?
    
    override func loadView() {
        super.loadView()
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(WTServiceCell.self, forCellWithReuseIdentifier: WTServiceCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsetsMake(75, 0, 75, 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
//        self.view.addSubview(collectionView)
        
        for i in 0...4 {
            let view: UIView = UIView()
            view.layer.cornerRadius = 35
            view.backgroundColor = UIColor.white
            view.layer.setShadow(5, color: UIColor.black, opacity: 0.08, X: 0, Y: 1)
            view.layer.masksToBounds = false
            view.clipsToBounds = true
            self.view.addSubview(view)
            
            let title: UILabel = UILabel()
            title.text = titles?[i]
            title.textColor = UIColor.black
            title.font = UIFont.get(.main, weight: .medium, size: 14)
            view.addSubview(title)
        }
        
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
        let w: CGFloat = 280
        collectionView.frame = CGRect(x: (self.view.frame.size.width - w) / 2, y: 0, width: w, height: self.view.frame.size.height)
        print("CCCCC")
        print(collectionView.frame)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            print("AAAAa")
            print(CGSize(width: collectionView.frame.size.width / 2 - 1, height: collectionView.frame.size.width / 2 - 1))
            return CGSize(width: collectionView.frame.size.width / 2 - 1, height: collectionView.frame.size.width / 2 - 1)
        } else {
            print("BBBBBB")
            print(CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width / 2 - 1))
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width / 2 - 1)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0 ? (services?.count ?? 5) - (services?.count ?? 5) % 2 : (services?.count ?? 5) % 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: WTServiceCell? = collectionView.dequeueReusableCell(withReuseIdentifier: WTServiceCell.reuseIdentifier, for: indexPath) as? WTServiceCell
        if cell == nil {
            cell = WTServiceCell()
        }
        return cell!
    }
}
