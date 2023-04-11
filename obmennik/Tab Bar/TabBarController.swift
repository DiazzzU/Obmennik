import UIKit

final class TabBarController: UITabBarController {
    
    var homeVC: HomeViewController? = nil
    var chatVC: ChatViewController? = nil
    var user: UserStruct? = nil
    var currencies: [CurrencyStruct] = []
    var offers: [OfferStruct] = []
    var watchlist: [OfferStruct] = []
    var userOffers: [OfferStruct] = []
    
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
    
    func setupTabBar(user: UserStruct, currencies: [CurrencyStruct], offers: [OfferStruct], watchlist: [OfferStruct], userOffers: [OfferStruct]) {
        self.user = user
        self.currencies = currencies
        self.offers = offers
        self.watchlist = watchlist
        self.userOffers = userOffers
        
        homeVC = HomeViewController()
        setupHomeVC()
        let navVC1 = UINavigationController(rootViewController: homeVC!)
        
        let sessionVC = SessionViewController()
        let navVC2 = UINavigationController(rootViewController: sessionVC)
        setupChatVC()
        
        let viewControllers = [navVC1, navVC2]
        setViewControllers(viewControllers, animated: true)
        
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
        homeVC!.setupLayers(user: user!, currencies: self.currencies, offers: self.offers, watchlist: self.watchlist, userOffers: self.userOffers)
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
