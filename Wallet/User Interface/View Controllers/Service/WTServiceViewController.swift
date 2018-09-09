//
//  WTProfileViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTServiceViewController: WTViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        self.view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle(String.localized("WT.Tab.Service"))
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.size.width / 2 - 1, height: collectionView.frame.size.width / 2 - 1)
        } else {
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
        switch indexPath.row {
        case 0:
            if indexPath.section == 0 {
                cell?.titleLabel.text = "شارژ"
                cell?.imageView.image = UIImage(named: "icon-service-charge")
            } else {
                cell?.titleLabel.text = "گزارش ها"
                cell?.imageView.image = UIImage(named: "icon-service-report")
            }
        case 1:
            cell?.titleLabel.text = "جریمه خودرو"
            cell?.imageView.image = UIImage(named: "icon-service-penalty")
        case 2:
            cell?.titleLabel.text = "طرح ترافیک"
            cell?.imageView.image = UIImage(named: "icon-service-traffic")
        case 3:
            cell?.titleLabel.text = "پرداخت قبوض"
            cell?.imageView.image = UIImage(named: "icon-service-bill")
        default:
            break
        }
        return cell!
    }
}
