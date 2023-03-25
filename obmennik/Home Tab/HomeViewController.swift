import UIKit

class HomeViewController: UIViewController {

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
    
    func addOffers(offer: OfferStruct) {
        offers.append(offer)
    }
    
    func setupLayers() {
        viewModels.setupLayers(parrent: view)
    }
    
    @objc func handleWatchlistButton(button: UIButton) {
        print(offers.count)
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
    }
    @objc func handleOfferButton(button: UIButton) {
        viewModels.changeOfferButtonState(offerButton: viewModels.offerTabButton)
        viewModels.changeWatchlistButtonState(watchlistButton: viewModels.watchlistTabButton)
    }
}
