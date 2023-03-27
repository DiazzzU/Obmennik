import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var user: UserStruct? = nil
    var window: UIWindow?
    var networkClient: NetworkClientImp? = nil
    var networkService: NetworkServiceImp? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        if user == nil {
            networkService!.createUser { result in
                switch result {
                case .success(let data):
                    self.user = UserStruct(name: data.user_name, rating: data.user_rating, id: data.user_id)
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        networkService!.getCurrencies { result in
            switch result {
            case .success(let data):
                for currency in data {
                    print(currency.currencyName)
                }
            case .failure(let error):
                print(error)
            }
        }
 
        
        let tabBar = TabBarController()
        tabBar.setupTabBar(user: UserStruct(name: "Dias", rating: 5.0, id: 0))
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        return true
    }
    
    func getUser() async {
        
    }
}

