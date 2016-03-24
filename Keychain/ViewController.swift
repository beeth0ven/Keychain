//
//  ViewController.swift
//  Keychain
//
//  Created by luojie on 16/3/24.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController, KeychainHandable, TouchIDHandable {
    
    let userNameKey = "hi"
    let passwordKey = "hallo"
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var touchIDButton: UIButton!
    
    private var userName: String {
        return userNameTextField.text ?? ""
    }
    
    private var password: String {
        return passwordTextField.text ?? ""
    }
    
    private var savedUserName = DiskVar<String>(key: "ViewController.savedUserName", defaultValue: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        userNameTextField.text = savedUserName.value
    }
    
    @IBAction func login(sender: UIButton) {
        
        guard userName == userNameKey &&
            password == passwordKey else {
                return print("Login failed UserName or Password Incorrect!")
        }
        
        savedUserName.value = userName
        secPassword = password
        
        print("Login Success!")
    }
    
    @IBAction func loginWithTouchID(sender: UIButton) {
        authorizeByTouchID(
            didAuthorize: {
                print("Login use touch id success!")
                self.passwordTextField.text = self.secPassword
                self.login(self.loginButton)
            },
            didFail: handleError
        )
    }
    
    private func handleError(error: LAError) {
        switch error {
        case .AuthenticationFailed:
            print("There was a problem verifying your identity.")
        case .UserCancel:
            print("You pressed cancel.")
        case .UserFallback:
            print("You pressed password.")
        default:
            print("Touch ID may not be configured")
            
        }
    }
}

