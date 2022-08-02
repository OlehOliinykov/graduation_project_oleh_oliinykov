//
//  ExtensionString.swift
//  GraduationProject
//
//  Created by Влад Овсюк on 19.01.2022.
//

import Foundation

extension String {
    enum ValidTypes {
        case email
        case password
        case name
        case familyName
    }
    
    enum RegEx: String {
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,}"
        case name = "[a-zA-Z]{2,}"
        case familyName = "[a-zA-Z]{1,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .email: regex = RegEx.email.rawValue
        case .password: regex =  RegEx.password.rawValue
        case .name: regex = RegEx.name.rawValue
        case .familyName: regex = RegEx.familyName.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
