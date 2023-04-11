import UIKit

final class CreateViewController: UIViewController {
    
    var user: UserStruct? = nil
    
    var viewModels: CreateViewModel = CreateViewModel()
    var homeVC: HomeViewController? = nil
    
    var changeLog: [Int] = [0, 2, 1]
    var currentExchangeRate: Float = 1
    var currentSellAmount: Float = 1
    var currentBuyAmount: Float = 1
    var currentFromCurrency: String = "RUB"
    var currentToCurrency: String = "KZT"
    
    var fromCurrency: CurrencyStruct? = nil
    var toCurrency: CurrencyStruct? = nil
    
    var networkClient: NetworkClientImp? = nil
    var networkService: NetworkServiceImp? = nil
    
    var currentOpenTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.backgroundMain
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        viewModels.amountToSellField.delegate = self
        viewModels.toRateField.delegate = self
        viewModels.fromRateField.delegate = self
        viewModels.amountToBuyField.delegate = self
        viewModels.currencyToBuyField.delegate = self
        viewModels.currencyToSellField.delegate = self
        
        viewModels.rateChangeButton.addTarget(self, action: #selector(handleRateChange), for: .touchUpInside)
        
        viewModels.createButton.startAnimatingPressActions()
        viewModels.createButton.addTarget(self, action: #selector(handleCreateButton), for: .touchUpInside)
        
        viewModels.closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
    }
    
    @objc func handleRateChange() {
        if viewModels.rightArrow.textColor == .white {
            viewModels.rightArrow.textColor = ColorPalette.secondaryOfferColor
            viewModels.leftArrow.textColor = .white
        } else {
            viewModels.rightArrow.textColor = .white
            viewModels.leftArrow.textColor = ColorPalette.secondaryOfferColor
        }
        viewModels.changeRateState(rateField: viewModels.fromRateField)
        viewModels.changeRateState(rateField: viewModels.toRateField)
    }
    
    @objc func handleCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestCompletion(offer: OfferQuery) {
        homeVC?.addOffers(offer: OfferStruct(offerId: offer.offerId, fromCurrency: fromCurrency!, toCurrency: toCurrency!,
                                             amountToBuy: offer.toAmount, amountToSell: offer.fromAmount,
                                             creator: UserStruct(name: offer.creator.user_name, rating: offer.creator.user_rating, id: offer.creator.user_id), isInWatchList: offer.isOnWatchlist))
        homeVC?.viewModels.offerTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCreateButton() {
        fromCurrency = homeVC?.getCurrency(capitalName: currentFromCurrency)
        toCurrency = homeVC?.getCurrency(capitalName: currentToCurrency)
        
        if fromCurrency != nil && toCurrency != nil {
            networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
            networkService = NetworkServiceImp(networkClient: networkClient!)
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                self.networkService!.createOffer(offer: OfferCreateQuery(fromCurrencyId: self.fromCurrency!.currencyId, toCurrencyId: self.toCurrency!.currencyId, fromAmount: self.currentSellAmount,
                                                                         toAmount: self.currentBuyAmount, exchangeRate: self.currentExchangeRate, creatorId: self.user!.id)) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.requestCompletion(offer: data)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    func recalculate() {
        if changeLog.last == 0 {
            currentSellAmount = currentBuyAmount / currentExchangeRate
            currentSellAmount = round(currentSellAmount * 100) / 100.0
            viewModels.amountToSellField.text = currentSellAmount.description
        } else if changeLog.last == 1 {
            currentBuyAmount = currentSellAmount * currentExchangeRate
            currentBuyAmount = round(currentBuyAmount * 100) / 100.0
            viewModels.amountToBuyField.text = currentBuyAmount.description
        } else if changeLog.last == 2 {
            currentExchangeRate = currentBuyAmount / currentSellAmount
            currentExchangeRate = round(currentExchangeRate * 100) / 100.0
            
            if viewModels.toRateField.isUserInteractionEnabled {
                viewModels.toRateField.text = currentExchangeRate.description
            } else {
                viewModels.fromRateField.text = (round(100.0 / currentExchangeRate) / 100.0).description
            }
        }
    }
    
    func setupLayers(homeVC: HomeViewController, user: UserStruct) {
        self.user = user
        self.homeVC = homeVC
        viewModels.setupViews(parrent: view)
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
}
