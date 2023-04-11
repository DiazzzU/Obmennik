import UIKit

final class EditViewController: UIViewController {
    var homeVC: HomeViewController? = nil
    var offerVC: OfferViewController? = nil
    var user: UserStruct? = nil
    var offer: OfferStruct? = nil
    
    let viewModels: EditViewModels = EditViewModels()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ColorPalette.backgroundMain
        self.title = "Edit Offer"
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        self.viewModels.cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        self.viewModels.rateChangeButton.addTarget(self, action: #selector(handleRateChange), for: .touchUpInside)
        self.viewModels.saveChangesButton.addTarget(self, action: #selector(handleSaveChangesButton), for: .touchUpInside)
        
        self.viewModels.saveChangesButton.startAnimatingPressActions()
        
        self.viewModels.amountToSellField.delegate = self
        self.viewModels.toRateField.delegate = self
        self.viewModels.fromRateField.delegate = self
        self.viewModels.amountToBuyField.delegate = self
        self.viewModels.currencyToBuyField.delegate = self
        self.viewModels.currencyToSellField.delegate = self
    }
    
    //Handle buttons
    
    @objc func handleCancelButton() {
        self.navigationController?.popViewController(animated:true)
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
    
    @objc func handleSaveChangesButton() {
        fromCurrency = homeVC?.getCurrency(capitalName: currentFromCurrency)
        toCurrency = homeVC?.getCurrency(capitalName: currentToCurrency)
        
        if fromCurrency != nil && toCurrency != nil {
            networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
            networkService = NetworkServiceImp(networkClient: networkClient!)
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                guard let self = self else { return }
                self.networkService!.editOffer(offer: OfferEditQuery(offerId: self.offer!.offerId, fromCurrencyId: self.fromCurrency!.currencyId, toCurrencyId: self.toCurrency!.currencyId, fromAmount: self.currentSellAmount,
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
    
    // Setup
    
    private func setupNavBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(10, for: .default)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewModels.cancelButton)
    }
    
    func setupData(offer: OfferStruct) {
        self.currentExchangeRate = offer.exchangeRate
        self.currentSellAmount = offer.amountToSell
        self.currentBuyAmount = offer.amountToBuy
        self.currentFromCurrency = offer.fromCurrency.capitalName
        self.currentToCurrency = offer.toCurrency.capitalName
    }
    
    func setupLayer(homeVC: HomeViewController, offerVC: OfferViewController, user: UserStruct, offer: OfferStruct) {
        self.homeVC = homeVC
        self.offerVC = offerVC
        self.user = user
        self.offer = offer
        setupData(offer: offer)
        setupNavBar()
        self.viewModels.setupViews(parrent: self.view, offer: offer)
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
    
    func requestCompletion(offer: OfferQuery) {
        let offerStruct = OfferStruct(offerId: offer.offerId, fromCurrency: fromCurrency!, toCurrency: toCurrency!,
                                      amountToBuy: offer.toAmount, amountToSell: offer.fromAmount,
                                      creator: UserStruct(name: offer.creator.user_name, rating: offer.creator.user_rating, id: offer.creator.user_id), isInWatchList: offer.isOnWatchlist)
        homeVC?.removeOffer(offerId: offer.offerId)
        homeVC?.addOffers(offer: offerStruct)
        homeVC?.viewModels.offerTableView.reloadData()
        offerVC?.setupLayers(homeVC: homeVC!, user: user!, data: offerStruct)
        
        self.navigationController?.popViewController(animated:true)
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
}
