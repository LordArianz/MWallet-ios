//
//  WTWalletServicesCell.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTWalletServicesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static let reuseIdentifier: String = "WTWalletServicesCell"
    
    var collectionView: UICollectionView!
    var layout: WTGridLayout!
    var services: [String]?

    init() {
        super.init(style: .default, reuseIdentifier: WTBalanceCell.reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        layout = WTGridLayout(numberOfColumns: 2, itemHeight: 130)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(WTWalletServiceCell.self, forCellWithReuseIdentifier: WTWalletServiceCell.reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self

        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
        let h: CGFloat = collectionView.frame.size.width * 0.325
        collectionView.collectionViewLayout = WTGridLayout(numberOfColumns: 2, itemHeight: h)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.services?.count ?? 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: WTWalletServiceCell? = collectionView.dequeueReusableCell(withReuseIdentifier: WTWalletServiceCell.reuseIdentifier, for: indexPath) as? WTWalletServiceCell
        if cell == nil {
            cell = WTWalletServiceCell()
        }
        cell?.setIsRight(indexPath.row % 2 == 1)
        cell?.imageView.image = UIImage(named: "icon-wallet-service\(indexPath.row)")
        return cell!
    }

}
