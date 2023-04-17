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
            
            var userId: Int? = nil
            var user: UserStruct? = nil
            var currencies: [CurrencyStruct] = []
            var offers: [OfferStruct] = []
            var watchlist: [OfferStruct] = []
            var userOffers: [OfferStruct] = []
            var sessions: [SessionStruct] = []
            
            let defaults = UserDefaults.standard
            
            
            userId = defaults.integer(forKey: "SavedUserId")
            
            if userId == 0 {
                group.enter()
                self.networkService!.createUser { result in
                    switch result {
                    case .success(let data):
                        user = UserStruct(data: data)
                        userId = user!.id
                        defaults.set(user!.id, forKey: "SavedUserId")
                    case .failure(let error):
                        print(error)
                    }
                    group.leave()
                }
                group.wait()
            }
            
            if user == nil {
                group.enter()
                self.networkService!.userInfo(userId: userId!) { result in
                    switch result {
                    case .success(let data):
                        user = UserStruct(data: data)
                    case .failure(let error):
                        print(error)
                    }
                    group.leave()
                }
                group.wait()
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
                        offers.append(OfferStruct(offer: offer, currencies: currencies))
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
                        watchlist.append(OfferStruct(offer: offer, currencies: currencies))
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
                        userOffers.append(OfferStruct(offer: offer, currencies: currencies))
                    }
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.enter()
            self.networkService!.getSessionList(userId: user!.id) { result in
                switch result {
                case .success(let data):
                    for session in data {
                        sessions.append(SessionStruct(session: session, currencies: currencies))
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
            print(sessions)
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tabBar.setupTabBar(user: user!, currencies: currencies, offers: offers, watchlist: watchlist, userOffers: userOffers, sessions: sessions)
                
                let navVC = UINavigationController(rootViewController: self.tabBar)
                self.window?.rootViewController = navVC
                self.socketConnect(user: user!)
                //self.getData()
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
    
    func socketConnect(user: UserStruct) {
        WSManager.shared.connectToWebSocket(user: user, tabBarController: self.tabBar)
    }
    
    func getData() {
        
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

