import UIKit

final class TabBarController: UITabBarController {
    
    var homeVC: HomeViewController? = nil
    var sessionVC: SessionViewController? = nil
    var profileVC = ProfileVieewController()
    
    var user: UserStruct? = nil
    var currencies: [CurrencyStruct] = []
    var offers: [OfferStruct] = []
    var watchlist: [OfferStruct] = []
    var userOffers: [OfferStruct] = []
    var sessions: [SessionStruct] = []
    
    var viewModels = TabBarModels()
    
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
        tabBar.unselectedItemTintColor = ColorPalette.unselectedElement
        tabBar.tintColor = .white
        tabBar.layer.cornerRadius = 32
        delegate = self
    }
    
    @objc func didCreateOfferButtonPressed() {
        //createButton.backgroundColor = .green
        let vc = CreateViewController()
        vc.setupLayers(homeVC: homeVC!)
        self.present(vc, animated: true)
    }
    
    func setupTabBar(user: UserStruct, currencies: [CurrencyStruct], offers: [OfferStruct], watchlist: [OfferStruct], userOffers: [OfferStruct], sessions: [SessionStruct]) {
        self.user = user
        self.currencies = currencies
        self.offers = offers
        self.watchlist = watchlist
        self.userOffers = userOffers
        self.sessions = sessions
        
        self.sessions.sort { $0.lastMessage < $1.lastMessage}
        
        homeVC = HomeViewController()
        setupHomeVC()
        
        sessionVC = SessionViewController()
        setupSessionVC()
        
        let viewControllers = [homeVC!, sessionVC!]
        setViewControllers(viewControllers, animated: true)
        
        setupNavBar()
        setupButtons()
        setupImages()
        setupUI()
    }
    
    func addSession(session: SessionQuery) {
        sessions.append(SessionStruct(session: session, currencies: self.currencies))
        sessions.sort { $0.lastMessage < $1.lastMessage}
        sessionVC!.updateSessions(sessions: sessions)
    }
    
    func addMessage(message: MessageQuery) {
        for i in 0..<sessions.count {
            if sessions[i].id == message.messageSessionId {
                sessions[i].messages.append(MessageStruct(message: message))
                sessions[i].messages.sort {$0.sentDate < $1.sentDate}
                break
            }
        }
        sessionVC!.updateSessions(sessions: sessions)
        sessionVC!.newMessage(message: MessageStruct(message: message))
    }
    
    func closeSession(sessionId: Int) {
        for i in 0..<sessions.count {
            if sessions[i].id == sessionId {
                sessions[i].state = .closed
                break
            }
        }
        sessionVC!.updateSessions(sessions: sessions)
        sessionVC!.closeSession(sessionId: sessionId)
    }
    
    func setupNavBar() {
        let leftNegativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftNegativeSpacer.width = 18
        navigationItem.leftBarButtonItems = [leftNegativeSpacer, UIBarButtonItem(customView: viewModels.profileButton)]
        let rightNegativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightNegativeSpacer.width = 16
        navigationItem.rightBarButtonItems = [rightNegativeSpacer, UIBarButtonItem(customView: viewModels.searchButton)]
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
    
    func setupSessionVC() {
        self.sessionVC!.setupData(tabBarController: self)
    }
    
    func setupHomeVC() {
        self.homeVC!.setupData(tabBarController: self)
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
    
    func setupButtons() {
        viewModels.profileButton.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
    }
    
    @objc func handleProfileButton() {
        profileVC.setupData(homeVC: homeVC!)
        navigationController?.pushViewController(profileVC, animated: true)
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
