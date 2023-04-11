import UIKit
import MessageKit

final class ChatViewController: MessagesViewController {
    var messages = [MessageStruct]()
    
    var selfSender: SenderStruct = SenderStruct(senderId: "asdasd", displayName: "DIAS")
    var secondSender: SenderStruct = SenderStruct(senderId: "asda", displayName: "NO DIAS")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        let titleLabel = UILabel()
        titleLabel.text = "WORK"
        navigationItem.titleView = titleLabel
        messagesCollectionView.backgroundColor = ColorPalette.chatMain
        messageInputBar.backgroundView.backgroundColor = ColorPalette.backgroundMain
        messageInputBar.inputTextView.backgroundColor = ColorPalette.chatMain
        messageInputBar.inputTextView.layer.cornerRadius = 10
        messageInputBar.inputTextView.placeholder = "Message"
        
        messageInputBar.padding.top = 10
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        for i in 0...20 {
            insertMessage(message: MessageStruct(sender: selfSender, messageId: "asd", sentDate: Date(), kind: .text("Helloasdasdasdasdadasdasda\(i)")))
            insertMessage(message: MessageStruct(sender: secondSender, messageId: "dsa", sentDate: Date(), kind: .text("Hi there\(i)")))
        }
        setupNavBar()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
    }
    
    func setupInputBar() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 43))
        messageInputBar.inputTextView.addSubview(leftView)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorPalette.backgroundMain
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func insertMessage(message: MessageStruct) {
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: false)
        }
    }
}
