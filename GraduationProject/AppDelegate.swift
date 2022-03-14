//
//  AppDelegate.swift
//  GraduationProject
//
//  Created by Олег Олейников on 25.12.2021.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@main

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.showModalAuth()
            }
        }
        return true
    }
    func showModalAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVc = storyboard.instantiateViewController(withIdentifier: "AuthController") as! AuthController
        self.window?.rootViewController?.present(newVc, animated: true, completion: nil)
    }
}

