//
//  WTGridLayout.swift
//  Wallet
//
//  Created by S.Morteza Ezzabady on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTGridLayout: UICollectionViewFlowLayout {
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = (collectionView.frame.width / CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                return CGSize(width: itemWidth, height: self.itemHeight)
            }
            
            return CGSize(width: 100, height: 100)
        }
        set {
            super.itemSize = newValue
        }
    }
    private var numberOfColumns: Int = 3
    private var itemHeight: CGFloat = 100
    
    init(numberOfColumns: Int, itemHeight: CGFloat) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        
        self.numberOfColumns = numberOfColumns
        self.itemHeight = itemHeight
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var flipsHorizontallyInOppositeLayoutDirection: Bool { return true }
    
}
