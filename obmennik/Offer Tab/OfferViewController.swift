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
    }
    
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
    
    func setupLayers(homeVC: HomeViewController, user: UserStruct, data: OfferStruct) {
        self.user = user
        self.homeVC = homeVC
        self.offer = data
        viewModels.setupViews(parrent: view, data: offer!)
    }
}
