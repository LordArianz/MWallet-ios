//
//  WTSelector.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

struct WTSelectorItem {
    let image: UIImage
    let title: String
}

class WTSelectorItemView: UIView {
    let imageView: UIImageView = UIImageView()
    let label: UILabel = UILabel()
    let rootView: UIView = UIView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = WTColor.wt_TabDeselectedTranslucent
        imageView.contentMode = .scaleAspectFit
        rootView.addSubview(imageView)
        rootView.addSubview(label)
        self.addSubview(rootView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSide: CGFloat = 24
        label.sizeToFit()
        imageView.frame = CGRect(x: 0, y: 0, width: imageSide, height: imageSide)
        /*rootView.frame.size = CGSize(width: imageSide + label.frame.size.width, height: imageSide)*/
        label.frame.origin.x = imageSide + 5
        rootView.frame.size = CGSize(width: imageSide + 5 + label.frame.size.width,
                                     height: max(imageSide, label.frame.size.height))
        label.center.y = rootView.frame.size.height / 2 + 3
        rootView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    }
}

class WTSelector: UIView {
    
    var onSelect: ((Int) -> ())?
    
    var _currentIndex: Int = 0
    var currentIndex: Int {
        set {
            _currentIndex = newValue
            indexChange()
        }
        get {
            return _currentIndex
        }
    }
    var items: [WTSelectorItem] = [WTSelectorItem(image: UIImage(), title: "")] {
        didSet {
            setItems()
        }
    }
    
    func setItems() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        for item in items {
            let view: WTSelectorItemView = WTSelectorItemView()
            view.imageView.image = item.image.withRenderingMode(.alwaysTemplate)
            view.label.text = item.title
            self.addSubview(view)
        }
        self.currentIndex = 0
    }
    
    func indexChange() {
        for subview in self.subviews {
            let view: WTSelectorItemView = subview as! WTSelectorItemView
            view.backgroundColor = WTColor.wt_TabDeselectedTranslucent
            view.imageView.tintColor = WTColor.wt_DarkCardText
            view.label.textColor = view.imageView.tintColor
            view.label.font = UIFont.get(.round, weight: .bold, size: 22)
        }
        let view: WTSelectorItemView = subviews[currentIndex] as! WTSelectorItemView
        view.backgroundColor = WTColor.wt_TabSelected
        onSelect?(currentIndex)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let index = Int(touch.location(in: self).x
                * CGFloat(items.count) / self.frame.size.width)
            self.currentIndex = index
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var i: Int = 0
        let subviewWidth: CGFloat = self.frame.size.width / CGFloat(self.subviews.count)
        for subview in self.subviews {
            subview.frame = CGRect(x: CGFloat(i) * subviewWidth, y: 0, width: subviewWidth, height: self.frame.size.height)
            i += 1
        }
    }

}
