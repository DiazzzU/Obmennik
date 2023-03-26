//
//  AppDelegate.swift
//  obmennik
//
//  Created by Dias Ussenov on 20.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var user: UserStruct = UserStruct(name: "Admin", rating: 5, id: 0)
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let networkService = NetworkServiceImp(networkClient: networkClient)
        
        networkService.createUser { result in
            switch result {
            case .success(let data):
                print(data.user_id)
                print(data.user_name)
                print(data.user_rating)
            case .failure(let error):
                print(error)
            }
        }
 
        
        let tabBar = TabBarController()
        tabBar.setupTabBar(user: user)
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        return true
    }
}

