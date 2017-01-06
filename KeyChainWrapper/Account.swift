//
//  Account.swift
//  KeyChainWrapper
//
//  Created by Ali Mashuri on 1/6/17.
//  Copyright © 2017 Ali Mashuri. All rights reserved.
//

import Foundation

class Account: NSObject, NSCoding {
    
    var email: String
    var token: String
    
    init(email: String, token: String) {
        self.email = email
        self.token = token
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let email = decoder.decodeObject(forKey: "email") as? String,
            let token = decoder.decodeObject(forKey: "token") as? String
            else { return nil }
        
        self.init(
            email: email,
            token: token
        )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.token, forKey: "token")
    }
}
