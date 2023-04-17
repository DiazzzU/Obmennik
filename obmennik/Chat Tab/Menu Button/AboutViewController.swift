import UIKit

class AboutViewController: UIViewController {
    let viewModels = AboutViewModels()
    
    var selfSender: SenderStruct? = nil
    var session: SessionStruct? = nil
    
    var chatVC: ChatViewController? = nil
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        viewModels.setupViews(parrent: view, data: session!.offer, user: selfSender!)
        
        setupButtons()
        
        if session!.type == .outcoming {
            viewModels.closeSessionButton.isHidden = true
        }
    }
    
    // MARK - Setup
    
    func setupData(chatVC: ChatViewController) {
        self.session = chatVC.session!
        self.selfSender = chatVC.selfSender
        self.chatVC = chatVC
    }
    
    func setupButtons() {
        viewModels.rateChangeButton.addTarget(self, action: #selector(handleRateChange), for: .touchUpInside)
        viewModels.closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        viewModels.closeSessionButton.addTarget(self, action: #selector(handleCloseSessionButton), for: .touchUpInside)
    }
    
    // MARK - Button Actions
    
    @objc func handleRateChange() {
        if viewModels.rightArrowRate.textColor == .white {
            viewModels.rightArrowRate.textColor = ColorPalette.secondaryOfferColor
            viewModels.leftArrowRate.textColor = .white
        } else {
            viewModels.rightArrowRate.textColor = .white
            viewModels.leftArrowRate.textColor = ColorPalette.secondaryOfferColor
        }
        viewModels.changeRateState(data: session!.offer)
    }
    
    @objc func handleCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCloseSessionButton() {
        print("HERE")
        self.chatVC?.closeSessionRequest()
    }
}
