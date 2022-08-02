//
//  UserDefaults.swift
//  GraduationProject
//
//  Created by Олег Олейников on 28.12.2021.
//

import Foundation

class UserDefault {
    
    static let shared = UserDefault()
    
    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue

    var users: [Users] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([Users].self, from: data)
            } else {
                return [Users]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)
            }
        }
    }
    
    enum SettingKeys: String {
        case users
    }
    
    func saveUser(firstName: String, familyName: String) {
        let user = Users(firstName: firstName, familyName: familyName)
        users.insert(user, at: 0)
    }
}
