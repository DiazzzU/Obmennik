import UIKit

final class TabBarController: UITabBarController {
    
    var homeVC: HomeViewController? = nil
    var chatVC: UIViewController? = nil
    var user: UserStruct? = nil
    
    private lazy var createButton: UIButton = {
        let middleButton = UIButton()
        middleButton.setImage(UIImage(named: "create"), for: .normal)
        middleButton.translatesAutoresizingMaskIntoConstraints = false
        middleButton.addTarget(self, action: #selector(didCreateOfferButtonPressed), for: .touchUpInside)
        return middleButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = ColorPalette.line.cgColor
        tabBar.backgroundColor = ColorPalette.backgroundMain
        tabBar.unselectedItemTintColor = ColorPalette.unselectedElement
        tabBar.tintColor = .white
        tabBar.layer.cornerRadius = 32
        delegate = self
    }
    
    @objc func didCreateOfferButtonPressed() {
        //createButton.backgroundColor = .green
        let vc = CreateViewController()
        vc.setupLayers(homeVC: homeVC!, user: user!)
        self.present(vc, animated: true)
    }
    
    func setupTabBar(user: UserStruct) {
        self.user = user
        homeVC = HomeViewController()
        setupHomeVC()
        chatVC = UIViewController()
        setupChatVC()
        
        let viewControllers = [homeVC!, chatVC!]
        setViewControllers(viewControllers, animated: false)
        
        setupImages()
        setupUI()
    }
    
    func setupUI() {
        tabBar.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            // 2.1
            createButton.heightAnchor.constraint(equalToConstant: 40),
            createButton.widthAnchor.constraint(equalToConstant: 40),
            // 2.2
            createButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 5)
        ])
    }
    
    func setupChatVC() {
        
    }
    
    func setupHomeVC() {
        let rubCurrency = CurrencyStruct(fullName: "ruble", shortName: "rub", unicodeCharacter: "\u{20BD}", logoColor: .blue)
        let kztCurrency = CurrencyStruct(fullName: "tenge", shortName: "kzt", unicodeCharacter: "\u{20B8}", logoColor: .systemGreen)
        let usdCurrency = CurrencyStruct(fullName: "dollar", shortName: "usd", unicodeCharacter: "\u{0024}", logoColor: .systemYellow)
        let euCurrency = CurrencyStruct(fullName: "euro", shortName: "eu", unicodeCharacter: "\u{20AC}", logoColor: .systemRed)
        
        homeVC!.addCurrency(currency: rubCurrency)
        homeVC!.addCurrency(currency: kztCurrency)
        homeVC!.addCurrency(currency: usdCurrency)
        homeVC!.addCurrency(currency: euCurrency)
        
        let offer1 = OfferStruct(fromCurrency: rubCurrency, toCurrency: kztCurrency, amountToSell: 10000, exchangeRate: 5.7, creator: UserStruct(name: "Dias", rating: 5.0, id: 0))
        let offer2 = OfferStruct(fromCurrency: kztCurrency, toCurrency: rubCurrency, amountToBuy: 10000, exchangeRate: 0.2, creator: UserStruct(name: "Dias", rating: 5.0, id: 0))
        let offer3 = OfferStruct(fromCurrency: usdCurrency, toCurrency: rubCurrency, amountToSell: 100, exchangeRate: 60, creator: UserStruct(name: "Beka", rating: 5.0, id: 0))
        let offer4 = OfferStruct(fromCurrency: euCurrency, toCurrency: kztCurrency, amountToSell: 40, exchangeRate: 500, creator: UserStruct(name: "Beka", rating: 5.0, id: 0))
        
        homeVC!.addOffers(offer: offer1)
        homeVC!.addOffers(offer: offer2)
        homeVC!.addOffers(offer: offer3)
        homeVC!.addOffers(offer: offer4)
        
        homeVC!.setupLayers(user: user!)
    }
    
    private func setupImages() {
        guard let viewControllers = viewControllers else {
            return
        }
        
        for i in 0..<viewControllers.count {
            tabBar.items![i].image = UIImage(named: Constants.imageNames[i])
            switch i {
            case 0:
                tabBar.items![i].imageInsets = UIEdgeInsets(top: 10, left: -40, bottom: -6, right: 0)
            case 1:
                tabBar.items![i].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -6, right: -40)
            default:
                print("Error")
                break
            }
        }
    }
}

extension TabBarController {
    enum Constants {
        static let imageNames: [String] = [
            "chart",
            "chat",
        ]
    }
}
