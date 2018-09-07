//
//  Number+Seperator.swift
//  Ketabchi
//
//  Created by Morteza Ezzabady on 1/25/18.
//  Copyright © 2018 Morteza Ezzabady. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fa_IR")
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
    static let simple: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fa_IR")
        formatter.groupingSeparator = ""
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
    var priceFormat: String {
        return formattedWithSeparator + " " + String.localized("WT.Currency")
    }
}
