//
//  HideKB+UIViewController.swift
//  Ketabchi
//
//  Created by Morteza Ezzabady on 1/19/18.
//  Copyright © 2018 Morteza Ezzabady. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
