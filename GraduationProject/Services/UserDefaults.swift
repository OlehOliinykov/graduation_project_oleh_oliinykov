//
//  UserDefaults.swift
//  GraduationProject
//
//  Created by Олег Олейников on 28.12.2021.
//

import Foundation


class UserDefault {
    
    static let shared = UserDefault()
    
    enum SettingKeys: String {
        case users
    }
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue

    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    func saveUser(firstName: String, familyName: String) {
        let user = User (firstName: firstName, familyName: familyName)
        users.insert(user, at: 0)
    }
    
}
