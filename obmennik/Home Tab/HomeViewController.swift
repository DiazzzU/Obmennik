import UIKit

class HomeViewController: UIViewController {

    var user: UserStruct? = nil
    
    var viewModels: HomeViewModels = HomeViewModels()
    
    var filterNames = ["Rating", "Amount", "Exchange rate"]
    var selectedFilterIndex = -1
    var selectedFilterState = 0
    
    var currencies: [CurrencyStruct] = []
    var offers: [OfferStruct] = []
    var watchList: [OfferStruct] = []
    var userOffers: [OfferStruct] = []
    
    var myTabBarController: TabBarController? = nil
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        
        viewModels.watchlistTabButton.addTarget(self, action: #selector(handleWatchlistButton), for: .touchUpInside)
        viewModels.offerTabButton.addTarget(self, action: #selector(handleOfferButton), for: .touchUpInside)
        
        viewModels.offerTableView.delegate = self
        viewModels.offerTableView.dataSource = self
        
        viewModels.watchlistTableView.delegate = self
        viewModels.watchlistTableView.dataSource = self
        
        viewModels.filterCollectionView.delegate = self
        viewModels.filterCollectionView.dataSource = self
        
        viewModels.setupLayers(parrent: view)
    }
    
    // MARK: - Functions
    
    func getCurrency(capitalName: String) -> CurrencyStruct? {
        for currency in currencies {
            if currency.capitalName == capitalName {
                return currency
            }
        }
        return nil
    }
    
    func addOffers(offer: OfferStruct) {
        offers.append(offer)
        myTabBarController?.offers.append(offer)
        if offer.isInWatchlist {
            watchList.append(offer)
            viewModels.watchlistTableView.reloadData()
            myTabBarController?.watchlist.append(offer)
        }
        if offer.creator.id == user!.id {
            userOffers.append(offer)
            myTabBarController!.profileVC.userOffers.append(offer)
            myTabBarController!.profileVC.viewModels.myOfferTableView.reloadData()
            myTabBarController?.userOffers.append(offer)
        }
    }
    
    func addWatchlist(offer: OfferStruct) {
        for i in 0..<offers.count{
            if (offers[i].offerId == offer.offerId) {
                offers[i].isInWatchlist = true
                myTabBarController!.offers[i].isInWatchlist = true
                break
            }
        }
        myTabBarController!.watchlist.append(offer)
        watchList.append(offer)
        viewModels.watchlistTableView.reloadData()
    }
    
    func removeWatchlist(offer: OfferStruct) {
        for i in 0..<offers.count {
            if (offers[i].offerId == offer.offerId) {
                offers[i].isInWatchlist = false
                myTabBarController!.offers[i].isInWatchlist = false
                break
            }
        }
        for i in 0..<watchList.count {
            if (watchList[i].offerId == offer.offerId) {
                watchList.remove(at: i)
                myTabBarController!.watchlist.remove(at: i)
                break
            }
        }
        viewModels.watchlistTableView.reloadData()
    }
    
    func removeOffer(offerId: Int) {
        for i in 0..<offers.count {
            if offers[i].offerId == offerId {
                offers.remove(at: i)
                myTabBarController?.offers.remove(at: i)
                break
            }
        }
        for i in 0..<watchList.count {
            if watchList[i].offerId == offerId {
                watchList.remove(at: i)
                viewModels.watchlistTableView.reloadData()
                myTabBarController?.watchlist.remove(at: i)
                break
            }
        }
        for i in 0..<userOffers.count {
            if userOffers[i].offerId == offerId {
                userOffers.remove(at: i)
                myTabBarController!.profileVC.userOffers.remove(at: i)
                myTabBarController!.profileVC.viewModels.myOfferTableView.reloadData()
                myTabBarController?.userOffers.remove(at: i)
                break
            }
        }
    }
    
    func sortOffers() {
        offers.sort {
            switch selectedFilterIndex {
            case 0:
                if selectedFilterState == 0 {
                    return ($0.creator.rating < $1.creator.rating)
                } else {
                    return ($1.creator.rating < $0.creator.rating)
                }
            case 1:
                if selectedFilterState == 0 {
                    return ($0.amountToSell < $1.amountToSell)
                } else {
                    return ($1.amountToSell < $0.amountToSell)
                }
            default:
                if selectedFilterState == 0 {
                    return ($0.exchangeRate < $1.exchangeRate)
                } else {
                    return ($1.exchangeRate < $0.exchangeRate)
                }
            }
        }
        viewModels.offerTableView.reloadData()
    }
    
    func renameUser(newUser: UserStruct) {
        for i in 0..<offers.count {
            if offers[i].creator.id == newUser.id {
                offers[i].creator = newUser
            }
        }
        for i in 0..<watchList.count {
            if watchList[i].creator.id == newUser.id {
                watchList[i].creator = newUser
            }
        }
        for i in 0..<userOffers.count {
            if userOffers[i].creator.id == newUser.id {
                userOffers[i].creator = newUser
            }
        }
        if self.user!.id == newUser.id {
            self.user = newUser
        }
        viewModels.offerTableView.reloadData()
        viewModels.watchlistTableView.reloadData()
    }
    
    func startMessage(offer: OfferStruct) {
        let chatVC = ChatViewController()
        let selfSender = SenderStruct(senderId: "\(user!.id)", displayName: user!.name)
        var tempSession = SessionStruct(id: -1, interlocutor: offer.creator, state: .open, type: .outcoming, messages: [], offer: offer, lastMessage: Date())
        
        for session in myTabBarController!.sessions {
            if session.state == .open && session.offer.offerId == offer.offerId {
                tempSession = session
                break
            }
        }
        
        chatVC.setupData(session: tempSession, selfSender: selfSender, tabBarController: myTabBarController!)
        //navigationController?.pushViewController(chatVC, animated: true)
        myTabBarController?.selectedIndex = 1
        myTabBarController?.sessionVC?.currentChatVC = chatVC
        myTabBarController?.sessionVC?.currentSession = tempSession
        myTabBarController?.sessionVC?.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    // MARK: - ButtonActions
    
    @objc func handleWatchlistButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
        viewModels.offerTableView.isHidden = true
        viewModels.watchlistTableView.isHidden = false
        viewModels.filterCollectionView.isHidden = true
    }
    
    @objc func handleOfferButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
        viewModels.offerTableView.isHidden = false
        viewModels.watchlistTableView.isHidden = true
        viewModels.filterCollectionView.isHidden = false
    }
    
    // MARK: - Setup
    
    func setupNavBar() {
        let leftNegativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftNegativeSpacer.width = 18
        navigationItem.leftBarButtonItems = [leftNegativeSpacer, UIBarButtonItem(customView: myTabBarController!.viewModels.profileButton)]
        let rightNegativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightNegativeSpacer.width = 16
        navigationItem.rightBarButtonItems = [rightNegativeSpacer, UIBarButtonItem(customView: myTabBarController!.viewModels.searchButton)]
    }

    func setupData(tabBarController: TabBarController) {
        self.myTabBarController = tabBarController
        self.user = tabBarController.user
        self.currencies = tabBarController.currencies
        self.offers = tabBarController.offers
        self.watchList = tabBarController.watchlist
        self.userOffers = tabBarController.userOffers
    }
}
