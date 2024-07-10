import Foundation
import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    private let isLoggedInKey = "isLoggedIn"
    private let userIdKey = "userId"
    
    private var deviceIdentifier: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    func setLoggedIn(_ isLoggedIn: Bool) {
        userDefaults.set(isLoggedIn, forKey: isLoggedInKey + deviceIdentifier)
    }
    
    func isLoggedIn() -> Bool {
        return userDefaults.bool(forKey: isLoggedInKey + deviceIdentifier)
    }
    
    func setUserId(_ userId: String?) {
        if let userId = userId {
            userDefaults.set(userId, forKey: userIdKey + deviceIdentifier)
        } else {
            userDefaults.removeObject(forKey: userIdKey + deviceIdentifier)
        }
    }
    
    func getUserId() -> String? {
        return userDefaults.string(forKey: userIdKey + deviceIdentifier)
    }
    
    func clearAllUserData() {
        userDefaults.removeObject(forKey: isLoggedInKey + deviceIdentifier)
        userDefaults.removeObject(forKey: userIdKey + deviceIdentifier)
        userDefaults.synchronize()
    }
}
