import UIKit

class HomeViewController: UIViewController {

    var user: UserStruct? = nil
    
    var viewModels: HomeViewModels = HomeViewModels()
    
    var profileVC: ProfileVieewController = ProfileVieewController()
    
    var filterNames = ["Rating", "Amount", "Exchange rate"]
    var selectedFilterIndex = -1
    var selectedFilterState = 0
    
    var currencies: [CurrencyStruct] = []
    var offers: [OfferStruct] = []
    var watchList: [OfferStruct] = []
    var userOffers: [OfferStruct] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        
        viewModels.watchlistTabButton.addTarget(self, action: #selector(handleWatchlistButton), for: .touchUpInside)
        viewModels.offerTabButton.addTarget(self, action: #selector(handleOfferButton), for: .touchUpInside)
        viewModels.profileButton.addTarget(self, action: #selector(handleProfileButton), for: .touchUpInside)
        
        viewModels.offerTableView.delegate = self
        viewModels.offerTableView.dataSource = self
        
        viewModels.watchlistTableView.delegate = self
        viewModels.watchlistTableView.dataSource = self
        
        viewModels.filterCollectionView.delegate = self
        viewModels.filterCollectionView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = ColorPalette.backgroundMain
        
        let leftNegativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftNegativeSpacer.width = 18
        navigationItem.leftBarButtonItems = [leftNegativeSpacer, UIBarButtonItem(customView: viewModels.profileButton)]
        let rightNegativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightNegativeSpacer.width = 16
        navigationItem.rightBarButtonItems = [rightNegativeSpacer, UIBarButtonItem(customView: viewModels.searchButton)]
    }
    
    
    // MARK: - Functions
    
    func setupData() {
        
    }
    
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
        if offer.isInWatchlist {
            watchList.append(offer)
            viewModels.watchlistTableView.reloadData()
        }
        if offer.creator.id == user!.id {
            userOffers.append(offer)
            profileVC.userOffers.append(offer)
            profileVC.viewModels.myOfferTableView.reloadData()
        }
    }
    
    func removeOffer(offerId: Int) {
        for i in 0..<offers.count {
            if offers[i].offerId == offerId {
                offers.remove(at: i)
                break
            }
        }
        for i in 0..<watchList.count {
            if watchList[i].offerId == offerId {
                watchList.remove(at: i)
                viewModels.watchlistTableView.reloadData()
                break
            }
        }
        for i in 0..<userOffers.count {
            if userOffers[i].offerId == offerId {
                userOffers.remove(at: i)
                profileVC.userOffers.remove(at: i)
                profileVC.viewModels.myOfferTableView.reloadData()
                break
            }
        }
    }
    
    func setupLayers(user: UserStruct, currencies: [CurrencyStruct], offers: [OfferStruct], watchlist: [OfferStruct], userOffers: [OfferStruct]) {
        self.user = user
        self.currencies = currencies
        self.offers = offers
        self.watchList = watchlist
        self.userOffers = userOffers
        viewModels.setupLayers(parrent: view)
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
    
    @objc func handleProfileButton() {
        profileVC.setupLayers(homeVC: self, user: user!, userOffers: self.userOffers)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
