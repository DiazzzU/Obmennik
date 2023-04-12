import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var user: UserStruct? = nil
    var tabBar: TabBarController = TabBarController()
    var window: UIWindow?
    var networkClient: NetworkClientImp? = nil
    var networkService: NetworkServiceImp? = nil
    
    func setupData() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            let group = DispatchGroup()
            
            var user: UserStruct? = nil
            var currencies: [CurrencyStruct] = []
            var offers: [OfferStruct] = []
            var watchlist: [OfferStruct] = []
            var userOffers: [OfferStruct] = []
            
            let defaults = UserDefaults.standard
            if let savedPerson = defaults.object(forKey: "SavedUser") as? Data {
                let decoder = JSONDecoder()
                if let loadedPerson = try? decoder.decode(UserStruct.self, from: savedPerson) {
                    user = loadedPerson
                }
            }
            if user == nil {
                group.enter()
                self.networkService!.createUser { result in
                    switch result {
                    case .success(let data):
                        user = UserStruct(name: data.user_name, rating: data.user_rating, id: data.user_id)
                        let encoder = JSONEncoder()
                        if let encoded = try? encoder.encode(user) {
                            let defaults = UserDefaults.standard
                            defaults.set(encoded, forKey: "SavedUser")
                        }
                    case .failure(let error):
                        print(error)
                    }
                    group.leave()
                }
            }
        
            group.enter()
            self.networkService!.getCurrencies { result in
                switch result {
                case .success(let data):
                    for currency in data {
                        currencies.append(CurrencyStruct(currencyId: currency.currencyId, fullName: currency.currencyName, shortName: currency.currencyCapitalName,
                                                         unicodeCharacter: CurrencyStruct.getUnicodeCharacter(unicodeSymbol: currency.unicodeSymbol), logoColor: UIColor(hex: currency.colorHex)!))
                    }
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.wait()
            
            group.enter()
            self.networkService!.getAllOffers(userId: user!.id) { result in
                switch result {
                case .success(let data):
                    for offer in data {
                        
                        var fromCurrency: CurrencyStruct? = nil
                        var toCurrency: CurrencyStruct? = nil
                        for currency in currencies {
                            if currency.currencyId == offer.fromCurrencyId {
                                fromCurrency = currency
                            }
                            if currency.currencyId == offer.toCurrencyId {
                                toCurrency = currency
                            }
                        }
                        
                        offers.append(OfferStruct(offerId: offer.offerId, fromCurrency: fromCurrency!, toCurrency: toCurrency!,
                                                  amountToBuy: offer.toAmount, amountToSell: offer.fromAmount,
                                                  creator: UserStruct(name: offer.creator.user_name, rating: offer.creator.user_rating, id: offer.creator.user_id), isInWatchList: offer.isOnWatchlist))
                    }
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.enter()
            self.networkService!.getUserWatchlist(userId: user!.id) { result in
                switch result {
                case .success(let data):
                    for offer in data {
                        
                        var fromCurrency: CurrencyStruct? = nil
                        var toCurrency: CurrencyStruct? = nil
                        for currency in currencies {
                            if currency.currencyId == offer.fromCurrencyId {
                                fromCurrency = currency
                            }
                            if currency.currencyId == offer.toCurrencyId {
                                toCurrency = currency
                            }
                        }
                        
                        watchlist.append(OfferStruct(offerId: offer.offerId, fromCurrency: fromCurrency!, toCurrency: toCurrency!,
                                                  amountToBuy: offer.toAmount, amountToSell: offer.fromAmount,
                                                  creator: UserStruct(name: offer.creator.user_name, rating: offer.creator.user_rating, id: offer.creator.user_id), isInWatchList: offer.isOnWatchlist))
                    }
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.enter()
            self.networkService!.getUserOffers(userId: user!.id) { result in
                switch result {
                case .success(let data):
                    for offer in data {
                        
                        var fromCurrency: CurrencyStruct? = nil
                        var toCurrency: CurrencyStruct? = nil
                        for currency in currencies {
                            if currency.currencyId == offer.fromCurrencyId {
                                fromCurrency = currency
                            }
                            if currency.currencyId == offer.toCurrencyId {
                                toCurrency = currency
                            }
                        }
                        
                        userOffers.append(OfferStruct(offerId: offer.offerId, fromCurrency: fromCurrency!, toCurrency: toCurrency!,
                                                  amountToBuy: offer.toAmount, amountToSell: offer.fromAmount,
                                                  creator: UserStruct(name: offer.creator.user_name, rating: offer.creator.user_rating, id: offer.creator.user_id), isInWatchList: offer.isOnWatchlist))
                    }
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.wait()
            
            print(offers)
            print(watchlist)
            print(userOffers)
            print(user)
            print(currencies)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tabBar.setupTabBar(user: user!, currencies: currencies, offers: offers, watchlist: watchlist, userOffers: userOffers)
                //let chatVC = ChatViewController()
                //let navVC = UINavigationController(rootViewController: chatVC)
                self.window?.rootViewController = self.tabBar
            }
        }
    }
    
    func setupNavTabBars() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = ColorPalette.backgroundMain
            navigationBarAppearance.shadowColor = ColorPalette.backgroundMain
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor = ColorPalette.backgroundMain
            tabBarApperance.shadowColor = ColorPalette.backgroundMain
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
            UITabBar.appearance().standardAppearance = tabBarApperance
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        setupData()
        
        let vc = UIViewController()
        vc.view.backgroundColor = ColorPalette.backgroundMain
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        setupNavTabBars()
        
        return true
    }
    
    func getUser() async {
        
    }
}

