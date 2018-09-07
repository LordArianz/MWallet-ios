//
//  WTCard.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

@objc class WTCard: Object {
    @objc dynamic var id: String!
    @objc dynamic var num: String!
    @objc dynamic var cvv2: NSNumber! = .init(0)
    @objc dynamic var expireDate: String!
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }

}
