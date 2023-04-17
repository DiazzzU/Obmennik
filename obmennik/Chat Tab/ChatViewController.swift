import UIKit
import MessageKit

final class ChatViewController: MessagesViewController {
    var viewModels = ChatViewModels()
    
    var session: SessionStruct? = nil
    var messages = [MessageStruct]()
    
    var selfSender: SenderStruct = SenderStruct(senderId: "asdasd", displayName: "DIAS")
    
    var currentStarChoosed: Int = 0
    
    var networkClient: NetworkClient? = nil
    var networkService: NetworkService? = nil
    
    var myTabBarController: TabBarController? = nil
    
    var transition = PanelTransition(height: 500)
    
    // MARK - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        setupButtons()
        setupInputBar()
        setupTitle(text: session!.interlocutor.name)
        setupMessagesCollectionView()
        
        setupNavBar()
        viewModels.setupLayers(parrent: view)
        
        if session!.type == .outcoming {
            transition = PanelTransition(height: 400)
        }
    }
    
    // MARK - Setup
    
    func setupInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        messageInputBar.backgroundView.backgroundColor = ColorPalette.backgroundMain
        messageInputBar.inputTextView.backgroundColor = ColorPalette.chatMain
        messageInputBar.inputTextView.layer.cornerRadius = 10
        
        messageInputBar.inputTextView.textColor = .white
        messageInputBar.inputTextView.placeholder = "Message"
        messageInputBar.padding.top = 10
        messageInputBar.isHidden = false
    }
    
    func setupMessagesCollectionView() {
        messagesCollectionView.backgroundColor = ColorPalette.chatMain
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messageCellDelegate = self
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewModels.backButton)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewModels.menuButton)
    }
    
    func setupTitle(text: String) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 16)
        navigationItem.titleView = titleLabel
    }
    
    func setupButtons() {
        viewModels.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        for i in 0..<5 {
            viewModels.stars[i].addTarget(self, action: #selector(handleStarButton), for: .touchUpInside)
        }
        viewModels.rateButton.startAnimatingPressActions()
        viewModels.rateButton.addTarget(self, action: #selector(handleRateButton), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        viewModels.menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }
    
    func setupData(session: SessionStruct, selfSender: SenderStruct, tabBarController: TabBarController) {
        self.session = session
        self.selfSender = selfSender
        for message in session.messages {
            insertMessage(message: message)
        }
        self.myTabBarController = tabBarController
    }
    
    // MARK - Functions
    
    func insertMessage(message: MessageStruct) {
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: false)
        }
    }
    
    func newMessage(message: MessageStruct) {
        insertMessage(message: message)
    }
    
    func closeSession() {
        messageInputBar.padding.top = 215
        messageInputBar.isHidden = true
        messagesCollectionView.isScrollEnabled = false
        viewModels.rateView.isHidden = false
    }
    
    func sendMessageRequest(message: MessageStruct) {
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        var text = ""
        if case .text(let value) = message.kind {
            text = value
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: message.sentDate)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.networkService!.sendMessage(message: MessageCreateQuery(senderId: message.sender.senderId.integerValue, sessionId: message.sessionId, messageDate: date, messageText: text)) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func createNewSessionRequest(message: MessageStruct) {
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        var text = ""
        if case .text(let value) = message.kind {
            text = value
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: message.sentDate)
        
        let messageQuery = MessageCreateQuery(senderId: message.sender.senderId.integerValue, sessionId: message.sessionId, messageDate: date, messageText: text)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.networkService!.createSession(session: SessionCreateQuery(ownerId: self.selfSender.senderId.integerValue, userIds: [self.selfSender.senderId.integerValue, self.session!.interlocutor.id], offerId: self.session!.offer.offerId, initialMessage: messageQuery)) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func closeSessionRequest() {
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.networkService!.closeSession(sessionId: self.session!.id) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func rateRequest() {
        networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        networkService = NetworkServiceImp(networkClient: networkClient!)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            self.networkService!.updateRating(userId: self.session!.offer.creator.id, newRating: Float(self.currentStarChoosed)) { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK - ButtonActions
    
    @objc func handleRateButton() {
        messageInputBar.padding.top = 10
        messageInputBar.isHidden = false
        messagesCollectionView.isScrollEnabled = true
        viewModels.rateView.isHidden = true
        rateRequest()
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleStarButton(button: UIButton) {
        for i in 0..<5 {
            viewModels.resetStarState(tag: i)
        }
        for i in 0...button.tag {
            viewModels.changeStarState(tag: i)
        }
        switch button.tag {
        case 0:
            viewModels.starDecsription.text = "User tried to trick me"
        case 1:
            viewModels.starDecsription.text = "Very long (days) and uncertaint communication"
        case 2:
            viewModels.starDecsription.text = "Hard and delayful (hours) communication"
        case 3:
            viewModels.starDecsription.text = "Tolerable delays (minutes) in communication"
        case 4:
            viewModels.starDecsription.text = "Honest, fast and easy communication"
        default:
            viewModels.starDecsription.text = "User deceived me"
        }
        currentStarChoosed = button.tag + 1
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: false)
        }
    }
    
    @objc func handleMenuButton() {
        let modalViewController = AboutViewController()
        modalViewController.setupData(chatVC: self)
        modalViewController.transitioningDelegate = transition
        modalViewController.modalPresentationStyle = .custom
        modalViewController.isModalInPresentation = true
        present(modalViewController, animated: true, completion: nil)
    }
    
    func didTapView() {
        self.messageInputBar.inputTextView.resignFirstResponder()
    }
}
