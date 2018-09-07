//
//  CALayer+NoAnimation.swift
//  TapTap
//
//  Created by Ebrahim Tahernejad on 8/26/18.
//  Copyright © 2018 Morteza Ezzabady. All rights reserved.
//

import UIKit

extension CALayer {
    class func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void){
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
    func setShadow(_ radius: CGFloat, color: UIColor, opacity: Float, X: CGFloat = 0, Y: CGFloat = 0) {
        self.shadowOpacity = opacity
        self.shadowColor = color.cgColor
        self.shadowRadius = radius
        self.shadowOffset = CGSize(width: X, height: Y)
    }
    func setBorder(_ width: CGFloat, color: UIColor) {
        self.borderColor = color.cgColor
        self.borderWidth = width
    }
}
extension CAGradientLayer {
    public convenience init(verticalWithColors colors: [UIColor], locations: [NSNumber]) {
        self.init()
        self.locations = locations
        self.colors = colors.map { $0.cgColor }
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 0, y: 1)
    }
    public convenience init(horizontalWithColors colors: [UIColor], locations: [NSNumber]) {
        self.init()
        self.locations = locations
        self.colors = colors.map { $0.cgColor }
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
    }
}
