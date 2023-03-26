import UIKit

class HomeViewController: UIViewController {

    var user: UserStruct? = nil
    
    var viewModels: HomeViewModels = HomeViewModels()
    
    var filterNames = ["Rating", "Amount", "Exchange rate"]
    var selectedFilterIndex = -1
    var selectedFilterState = 0
    
    var currencies: [CurrencyStruct] = []
    var offers: [OfferStruct] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        
        viewModels.watchlistTabButton.addTarget(self, action: #selector(handleWatchlistButton), for: .touchUpInside)
        viewModels.offerTabButton.addTarget(self, action: #selector(handleOfferButton), for: .touchUpInside)
        
        viewModels.offerTableView.delegate = self
        viewModels.offerTableView.dataSource = self
        
        viewModels.filterCollectionView.delegate = self
        viewModels.filterCollectionView.dataSource = self
    }
    
    
    // MARK: - Functions
    
    func setupData() {
        
    }
    
    func addCurrency(currency: CurrencyStruct) {
        currencies.append(currency)
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
    }
    
    func setupLayers(user: UserStruct) {
        self.user = user
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
    
    @objc func handleWatchlistButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
    }
    @objc func handleOfferButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
    }
}
