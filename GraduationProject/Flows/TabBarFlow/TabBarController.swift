//
//  TabBarController.swift
//  GraduationProject
//
//  Created by Влад Овсюк on 18.04.2022.
//

import UIKit
import SwiftUI

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    func setupTabBar() {
        let mainScreenController = UIStoryboard(name: "MainScreen", bundle: nil).instantiateViewController(withIdentifier: "MainScreen") as! MainScreenController
        let profileController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! ProfileController

        let navProfile = generateNavController(vc: profileController, title: "Profile", image: UIImage(imageLiteralResourceName: "User"))
        let navMain = generateNavController(vc: mainScreenController, title: "Search", image: UIImage(imageLiteralResourceName: "Search"))
        
        viewControllers = [navProfile, navMain]
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
