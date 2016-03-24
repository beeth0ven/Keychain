//
//  DiskVar.swift
//  UserDefaults
//
//  Created by luojie on 16/1/14.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

/**
 Provide a convenience method to access NSUserDefaults,
 usage:
 
 ```swift
 class ViewController: UIViewController {
 
    private var history = DiskVar<[String]>(key: "ViewController.history", defaultValue: ["Wuhan"])
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // get
        print(history.rawValue)
 
        // set
        history.rawValue.append("ChangSha")
        print(history.rawValue)
    }
 
 }
 ```
 */
struct DiskVar<VarType> {
    let key: String
    let defaultValue: VarType
    
    var value: VarType {
        get { return userDefaults.objectForKey(key) as? VarType ?? defaultValue }
        set { userDefaults.setObject(newValue as? AnyObject, forKey: key); userDefaults.synchronize() }
    }
    
    private var userDefaults: NSUserDefaults { return NSUserDefaults.standardUserDefaults() }
    
}

