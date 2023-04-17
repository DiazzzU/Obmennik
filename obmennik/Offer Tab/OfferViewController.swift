import UIKit

final class OfferViewController: UIViewController {
    
    var user: UserStruct? = nil
    var homeVC: HomeViewController? = nil
    var offer: OfferStruct? = nil
    
    var viewModels: OfferViewModels = OfferViewModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ColorPalette.backgroundMain
        viewModels.rateChangeButton.addTarget(self, action: #selector(handleRateChange), for: .touchUpInside)
        viewModels.closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        viewModels.watchListButton.addTarget(self, action: #selector(handleWatchListButton), for: .touchUpInside)
        viewModels.editButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        viewModels.startChatButton.addTarget(self, action: #selector(handleStartMessageButton), for: .touchUpInside)
        
        viewModels.editButton.startAnimatingPressActions()
        viewModels.watchListButton.startAnimatingPressActions()
        
        setupNavBarItems()
    }
    
    
    // Button handles
    
    @objc func handleRateChange() {
        if viewModels.rightArrowRate.textColor == .white {
            viewModels.rightArrowRate.textColor = ColorPalette.secondaryOfferColor
            viewModels.leftArrowRate.textColor = .white
        } else {
            viewModels.rightArrowRate.textColor = .white
            viewModels.leftArrowRate.textColor = ColorPalette.secondaryOfferColor
        }
        viewModels.changeRateState(data: offer!)
    }
    
    @objc func handleCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleWatchListButton() {
        if viewModels.watchListButton.tag == 2 {
            self.sendAddWatchlistRequest()
            offer!.isInWatchlist = true
            homeVC!.addWatchlist(offer: offer!)
        } else {
            self.sendRemoveWatchlistRequest()
            offer!.isInWatchlist = false
            homeVC!.removeWatchlist(offer: offer!)
        }
        viewModels.changeWatchListButtonState()
    }
    
    @objc func handleEditButton() {
        let vc = EditViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.setupLayer(homeVC: homeVC!, offerVC: self, user: user!, offer: offer!)
    }
    
    @objc func handleStartMessageButton() {
        self.dismiss(animated: true) {
            self.homeVC!.startMessage(offer: self.offer!)
        }
    }
    
    // Setup
    
    func setupNavBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewModels.closeButton)
    }
    
    func setupData(homeVC: HomeViewController, offer: OfferStruct) {
        self.user = homeVC.user
        self.homeVC = homeVC
        self.offer = offer
        viewModels.setupViews(parrent: view, data: self.offer!, user: self.user!)
    }
}
