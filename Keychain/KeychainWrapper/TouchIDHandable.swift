//
//  TouchIDHandable.swift
//  Keychain
//
//  Created by luojie on 16/3/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol TouchIDHandable { }

extension TouchIDHandable {

    func authorizeByTouchID(didAuthorize didAuthorize: () -> Void, didFail:((LAError) -> Void)? = nil) {
        context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Logging in with Touch ID") {
            success, error in
            Queue.Main.execute {
                guard error == nil else {
                    let error = LAError(rawValue: error!.code)!
                    didFail?(error)
                    return
                }
                didAuthorize()
            }
        }
    }
    
    var touchIDEnable: Bool {
        return context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    private var context: LAContext {
        return LAContext()
    }
    
}
