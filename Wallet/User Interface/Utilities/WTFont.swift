//
//  WTFont.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/6/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit

enum WTFont: String {
    case main = "IRANSansMobile"
    case mainFaNum = "IRANSansMobileNoEn"
    case round = "TTRounds"
}

enum WTFontWeight: String {
    case bold = "Bold"
    case black = "Black"
    case regular = ""
    case medium = "Medium"
    case light = "Light"
    case ultraLight = "UltraLight"
}

fileprivate var WTFontCache: [String:[CGFloat:UIFont]] = [:]

extension UIFont {
    static func printAll() {
        for item in UIFont.familyNames {
            print(item)
            if item.contains("Sans") {
                print("-")
                for i in UIFont.fontNames(forFamilyName: item) {
                    print(i)
                }
                print("-")
            }
        }
    }
    static func get(_ font: WTFont, weight: WTFontWeight, size: CGFloat) -> UIFont {
        let fontName = "\(font.rawValue)\(weight.rawValue == "" ? "" : "-")\(weight.rawValue)"
        var font: UIFont? = nil
        if WTFontCache.keys.contains(fontName) {
            if WTFontCache[fontName]!.keys.contains(size) {
                font = WTFontCache[fontName]![size]!
            }
        } else {
            WTFontCache[fontName] = [:]
        }
        if font == nil {
            font = UIFont(name: fontName, size: size)
            WTFontCache[fontName]![size] = font
        }
        return font!
    }
}
