//
//  UIView+Shadow+Corner.swift
//  Ketabchi
//
//  Created by Morteza Ezzabady on 1/18/18.
//  Copyright © 2018 Morteza Ezzabady. All rights reserved.
//

import UIKit

extension UIView {
    func setShadow(_ radius: CGFloat, offset: CGSize, color: UIColor = UIColor.black, alpha: Float = 0.3){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = alpha
    }
    func setCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    func setBorder(_ width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
