import UIKit
import MessageKit

final class ChatViewController: MessagesViewController {
    var viewModels = ChatViewModels()
    
    var session: SessionStruct? = nil
    var messages = [MessageStruct]()
    
    var selfSender: SenderStruct = SenderStruct(senderId: "asdasd", displayName: "DIAS")
    
    var currenStarChoosed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        setupButtons()
        setupNavBar()
        setupInputBar()
        setupTitle(text: session!.interlocutor.name)
        setupMessagesCollectionView()
        
        viewModels.setupLayers(parrent: view)
    }
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: viewModels.backButton)
        navigationItem.largeTitleDisplayMode = .never
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
    }
    
    func closeSession() {
        messageInputBar.padding.top = 215
        messageInputBar.isHidden = true
        messagesCollectionView.isScrollEnabled = false
        viewModels.rateView.isHidden = false
    }
    
    func setupData(session: SessionStruct, selfSender: SenderStruct) {
        self.session = session
        self.selfSender = selfSender
        for message in session.messages {
            insertMessage(message: message)
        }
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
        currenStarChoosed = button.tag + 1
    }
    
    @objc func handleRateButton() {
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: false)
        }
    }
    
    func didTapView() {
        self.messageInputBar.inputTextView.resignFirstResponder()
    }
    
    func insertMessage(message: MessageStruct) {
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: false)
        }
    }
}
