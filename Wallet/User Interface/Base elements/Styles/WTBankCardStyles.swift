//
//  WTBankCardColors.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/6/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

enum WTBankCardStyleType: String {
    case mellat = "mellat"
    case saderat = "saderat"
    case parsian = "parsian"
    case none = "none"
}

struct WTBankCardStyle {
    let left: String
    let right: String
    let code: String
}

let WTBankCardStyles: [WTBankCardStyleType:WTBankCardStyle] = [
    .saderat: .init(left: "#2C7DCA" , right: "#67B5FD", code: "603769"),
    .mellat: .init(left: "#CB2525" , right: "#FFB534", code: "610433"),
    .parsian: .init(left: "#692323" , right: "#FD6767", code: "622106"),
    .none: .init(left: "#B8B8B8" , right: "#B8B8B8", code: "-")
]

