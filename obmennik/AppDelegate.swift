//
//  AppDelegate.swift
//  obmennik
//
//  Created by Dias Ussenov on 20.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        let homeVC1 = HomeViewController()
        let homeVC2 = HomeViewController()
        
        let tabBar = TabBarController()
        tabBar.setViewControllers([homeVC1, homeVC2], animated: false)
        tabBar.setupTabBar()
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        return true
    }
}

