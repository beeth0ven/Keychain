//
//  KeychainHandable.swift
//  Keychain
//
//  Created by luojie on 16/3/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

protocol KeychainHandable: class {}

extension KeychainHandable {
    var secPassword: String {
        get { return keychain.myObjectForKey(kSecValueData) as? String ?? "" }
        set { keychain.mySetObject(newValue, forKey: kSecValueData) }
    }
    
    private var keychain: KeychainWrapper {
        return KeychainWrapper()
    }
}
