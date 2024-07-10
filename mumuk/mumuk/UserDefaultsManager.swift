//
//  UserDefaultsManager.swift
//  mumuk
//
//  Created by 김현중 on 7/10/24.
//

import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    private let isLoggedInKey = "isLoggedIn"
    private let userIdKey = "userId"
    
    func setLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: isLoggedInKey)
    }
    
    func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: isLoggedInKey)
    }
    
    func setUserId(_ userId: String) {
        userDefaults.set(userId, forKey: userIdKey)
    }
    
    func getUserId() -> String? {
        return userDefaults.string(forKey: userIdKey)
    }
    
    func setUserId(_ userId: String?) {
          if let userId = userId {
              userDefaults.set(userId, forKey: userIdKey)
          } else {
              userDefaults.removeObject(forKey: userIdKey)
          }
      }
}
