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
        
        viewModels.editButton.startAnimatingPressActions()
        viewModels.watchListButton.startAnimatingPressActions()
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
            for i in 0..<homeVC!.offers.count{
                if (homeVC!.offers[i].offerId == offer?.offerId) {
                    homeVC!.offers[i].isInWatchlist = true
                    break
                }
            }
            
            homeVC!.watchList.append(offer!)
            homeVC!.viewModels.watchlistTableView.reloadData()
        } else {
            self.sendRemoveWatchlistRequest()
            offer!.isInWatchlist = false
            for i in 0..<homeVC!.offers.count {
                if (homeVC!.offers[i].offerId == offer?.offerId) {
                    homeVC!.offers[i].isInWatchlist = false
                    break
                }
            }
            for i in 0..<homeVC!.watchList.count {
                if (homeVC!.watchList[i].offerId == offer?.offerId) {
                    homeVC!.watchList.remove(at: i)
                    break
                }
            }
            homeVC!.viewModels.watchlistTableView.reloadData()
        }
        viewModels.changeWatchListButtonState()
    }
    
    @objc func handleEditButton() {
        let vc = EditViewController()
        //vc.setupLayer(homeVC: homeVC!, user: user!, offer: offer!)
        navigationController?.pushViewController(vc, animated: true)
        vc.setupLayer(homeVC: homeVC!, offerVC: self, user: user!, offer: offer!)
    }
    
    // Setup
    
    func setupNavBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewModels.closeButton)
    }
    
    func setupLayers(homeVC: HomeViewController, user: UserStruct, data: OfferStruct) {
        self.user = user
        self.homeVC = homeVC
        self.offer = data
        setupNavBarItems()
        viewModels.setupViews(parrent: view, data: self.offer!, user: self.user!)
    }
}
