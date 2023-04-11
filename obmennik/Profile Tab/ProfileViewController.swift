import UIKit

final class ProfileVieewController: UIViewController {
    var user: UserStruct? = nil
    var homeVC: HomeViewController? = nil
    var userOffers: [OfferStruct] = []
    
    var viewModels: ProfileViewModels = ProfileViewModels()
    
    override func viewDidLoad() {
        view.backgroundColor = ColorPalette.backgroundMain
        
        viewModels.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        viewModels.editNameButton.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        
        viewModels.myOfferTableView.delegate = self
        viewModels.myOfferTableView.dataSource = self
        
        super.viewDidLoad()
    }
    
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewModels.backButton)
        navigationItem.titleView = viewModels.titleView
    }
    
    func renameUser(newUser: UserStruct) {
        for i in 0..<userOffers.count {
            if userOffers[i].creator.id == newUser.id {
                userOffers[i].creator = newUser
            }
        }
        if self.user!.id == newUser.id {
            self.user = newUser
        }
        viewModels.myOfferTableView.reloadData()
        homeVC!.renameUser(newUser: newUser)
    }
    
    func setupLayers(homeVC: HomeViewController, user: UserStruct, userOffers: [OfferStruct]) {
        self.homeVC = homeVC
        self.user = user
        self.userOffers = userOffers
        
        setupNavBar()
        
        viewModels.setupLayers(parrent: view, user: user)
    }
    
    private let transition = PanelTransition()
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleEditButton() {
        let vc = RenameViewController()
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
        vc.setupLayers(profileVC: self, user: user!)
        present(vc, animated: true)
    }
}
