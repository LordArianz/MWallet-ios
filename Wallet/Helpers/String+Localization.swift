//
//  String+Localization.swift
//  Ketabchi
//
//  Created by Morteza Ezzabady on 12/24/17.
//  Copyright © 2017 Morteza Ezzabady. All rights reserved.
//

import Foundation


extension String {
    static func localized(_ phrase: String) -> String {
        return NSLocalizedString(phrase, tableName: Config.language,
                                 bundle: Bundle.main, value: phrase, comment: "")
    }
    var localizedFormat: String {
        return self.replacingOccurrences(of: "0", with: "۰")
        .replacingOccurrences(of: "1", with: "۱")
        .replacingOccurrences(of: "2", with: "۲")
        .replacingOccurrences(of: "3", with: "۳")
        .replacingOccurrences(of: "4", with: "۴")
        .replacingOccurrences(of: "5", with: "۵")
        .replacingOccurrences(of: "6", with: "۶")
        .replacingOccurrences(of: "7", with: "۷")
        .replacingOccurrences(of: "8", with: "۸")
        .replacingOccurrences(of: "9", with: "۹")
    }
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return true }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}

