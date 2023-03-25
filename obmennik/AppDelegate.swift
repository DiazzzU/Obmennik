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
        
        let rubCurrency = CurrencyStruct(fullName: "ruble", shortName: "rub", unicodeCharacter: "\u{20BD}", logoColor: .blue)
        let kztCurrency = CurrencyStruct(fullName: "tenge", shortName: "kzt", unicodeCharacter: "\u{20B8}", logoColor: .systemGreen)
        let usdCurrency = CurrencyStruct(fullName: "dollar", shortName: "usd", unicodeCharacter: "\u{0024}", logoColor: .systemYellow)
        let euCurrency = CurrencyStruct(fullName: "euro", shortName: "eu", unicodeCharacter: "\u{20AC}", logoColor: .systemRed)
        
        homeVC1.addCurrency(currency: rubCurrency)
        homeVC1.addCurrency(currency: kztCurrency)
        homeVC1.addCurrency(currency: usdCurrency)
        homeVC1.addCurrency(currency: euCurrency)
        
        let offer1 = OfferStruct(fromCurrency: rubCurrency, toCurrency: kztCurrency, amountToSell: 10000, exchangeRate: 5.7, creator: CreatorStruct(name: "Dias", rating: 5.0))
        let offer2 = OfferStruct(fromCurrency: kztCurrency, toCurrency: rubCurrency, amountToBuy: 10000, exchangeRate: 0.2, creator: CreatorStruct(name: "Dias", rating: 5.0))
        let offer3 = OfferStruct(fromCurrency: usdCurrency, toCurrency: rubCurrency, amountToSell: 100, exchangeRate: 60, creator: CreatorStruct(name: "Beka", rating: 5.0))
        let offer4 = OfferStruct(fromCurrency: euCurrency, toCurrency: kztCurrency, amountToSell: 40, exchangeRate: 500, creator: CreatorStruct(name: "Beka", rating: 5.0))
        
        homeVC1.addOffers(offer: offer1)
        homeVC1.addOffers(offer: offer2)
        homeVC1.addOffers(offer: offer3)
        homeVC1.addOffers(offer: offer4)
        
        homeVC1.setupLayers()
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        return true
    }
}

