//
//  WTTabBar.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/6/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

class WTTabBarButton: UIView {
    let imageView: UIImageView = UIImageView()
    let notificationLayer: CALayer = CALayer()
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.layer.addSublayer(notificationLayer)
        notificationLayer.frame.size = CGSize(width: 5, height: 5)
        notificationLayer.cornerRadius = 2.5
        imageView.contentMode = .center
        notificationLayer.backgroundColor = WTColor.wt_NotificationIndicator.cgColor
        notificationLayer.opacity = 0
    }
    required convenience init?(coder aDecoder: NSCoder) { self.init() }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
        notificationLayer.frame.origin
            = CGPoint(x: (self.frame.size.width - notificationLayer.frame.size.width) / 2,
                      y: self.frame.size.height - 5 - notificationLayer.frame.size.height)
    }
}

class WTTabBar: UIView {
    
    // constants
    let container: UIView = UIView()
    let topCurve: UIImageView =
        UIImageView(image: UIImage.init(named: "path-tab-top")!
            .withRenderingMode(.alwaysTemplate))
    
    // vars
    var onSelect: ((_ index: Int) -> ())?
    var _currentIndex: Int = 0
    var currentIndex: Int {
        set {
            var val = newValue
            if val >= container.subviews.count {
                val = container.subviews.count - 1
            } else if val < 0 {
                val = 0
            }
            if val != _currentIndex {
                _currentIndex = val
                changeIndex()
            }
        }
        get { return _currentIndex }
    }
    var notifications: [Int] = [] {
        didSet { setNotifications() }
    }
    var buttons: [UIImage] = [UIImage()] {
        didSet { setData() }
    }
    
    // methods
    func setNotifications() {
        var index: Int = 0
        for subview in container.subviews {
            print("wow")
            let view: WTTabBarButton = subview as! WTTabBarButton
            view.notificationLayer.opacity = notifications.contains(index) ? 1 : 0
            index += 1
        }
    }
    func setData() {
        for subview in container.subviews {
            subview.removeFromSuperview()
        }
        for button in buttons {
            let view: WTTabBarButton = WTTabBarButton()
            view.imageView.image = button.withRenderingMode(.alwaysTemplate)
            self.container.addSubview(view)
        }
        setNotifications()
        changeIndex()
    }
    func changeIndex() {
        for subview in container.subviews {
            let imageView: UIImageView = subview.subviews[0] as! UIImageView
            imageView.tintColor = WTColor.wt_TabDeselected
        }
        let view: WTTabBarButton = container.subviews[currentIndex] as! WTTabBarButton
        let imageView: UIImageView = view.imageView
        imageView.tintColor = WTColor.wt_TabSelected
        onSelect?(currentIndex)
    }
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.addSubview(topCurve)
        self.addSubview(container)
        self.layer.setShadow(15, color: .black, opacity: 0.05)
        container.layer.masksToBounds = false
        container.clipsToBounds = false
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        topCurve.tintColor = WTColor.wt_BarBackground
        topCurve.contentMode = .scaleAspectFit
        self.backgroundColor = WTColor.wt_BarBackground
    }
    required convenience init?(coder aDecoder: NSCoder) { self.init() }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let first = touches.first {
            self.currentIndex = Int(first.location(in: self).x * CGFloat(buttons.count) / self.frame.size.width)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var containerHeight: CGFloat = self.frame.size.height
        print("now \(containerHeight)")
        if #available(iOS 11.0, *) {
            containerHeight -= AppDelegate.window!.safeAreaInsets.bottom
            print("now after \(containerHeight)")
        }
        container.frame = CGRect(x: 0, y: 0,
                                 width: self.frame.size.width,
                                 height: containerHeight)
        let width: CGFloat = self.frame.size.width / CGFloat(buttons.count)
        print(width)
        var x: CGFloat = 0
        for subview in container.subviews {
            subview.frame = CGRect(x: x, y: 0, width: width, height: containerHeight)
            x += width
        }
        let mid: UIView = container.subviews[Int(buttons.count / 2)]
        mid.frame.origin.y -= 4
        let relation: CGFloat = self.frame.size.width / 375.0
        topCurve.frame = CGRect(x: 0, y: -8.5 * relation, width: 75.0 * relation, height: 12 * relation)
        topCurve.center.x = self.frame.size.width / 2
    }
}
