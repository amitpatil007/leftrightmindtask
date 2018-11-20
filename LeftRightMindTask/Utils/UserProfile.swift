//
//  UserProfile.swift
//  
//
//  Created by Admin on 11/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import Foundation
import UIKit

class UserProfile {
    
    //store remember me details
    static func saveRememberMe(userInfo: [String: Any]?) {
        guard let userData = userInfo else {
            print("Empty user data")
            return
        }
        
        if UserDefaults.standard.value(forKey: "LOGIN_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "LOGIN_DATA")
        }
        UserDefaults.standard.set(userData, forKey: "LOGIN_DATA")
        UserDefaults.standard.synchronize()
    }
    
    static func getRemeberMe() -> [String: Any]?{
        guard let userInfo = UserDefaults.standard.value(forKeyPath: "LOGIN_DATA") else {
            print("Empty user data")
            return nil
        }
        return userInfo as? [String : Any]
    }
    
    static func removeUserDetails() {

        if UserDefaults.standard.value(forKey: "LOGIN_DATA") != nil {
            UserDefaults.standard.removeObject(forKey: "LOGIN_DATA")
        }
        UserDefaults.standard.synchronize()
        
        
    }
    
}

