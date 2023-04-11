import UIKit

class RenameViewController: UIViewController {
    var user: UserStruct? = nil
    let viewModel: RenameViewModel = RenameViewModel()
    
    var currentUserName: String = ""
    
    var networkClient: NetworkClientImp? = nil
    var networkService: NetworkServiceImp? = nil
    
    var profileVC: ProfileVieewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
        viewModel.userNameField.delegate = self
        
        viewModel.cancelButton.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        
        viewModel.saveChangesButton.addTarget(self, action: #selector(handleSaveChangesButton), for: .touchUpInside)
        viewModel.saveChangesButton.startAnimatingPressActions()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func handleSaveChangesButton() {
        print(currentUserName)
        
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.networkService!.renameUser(userId: self.user!.id, newName: self.currentUserName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.requestCompletion(user: UserStruct(name: data.user_name, rating: data.user_rating, id: data.user_id))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    func setupLayers(profileVC: ProfileVieewController, user: UserStruct) {
        self.user = user
        self.profileVC = profileVC
        currentUserName = user.name
        viewModel.setupLayers(parrent: view, user: user)
    }
    
    func requestCompletion(user: UserStruct) {
        profileVC!.viewModels.titleLabel.text = user.name
        profileVC!.renameUser(newUser: user)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedUser")
        }
        dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func didTapView() {
        self.view.endEditing(true)
    }
}
