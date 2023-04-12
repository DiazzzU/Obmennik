import UIKit

class SessionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.backgroundMain
    }
    
    @objc func handleButton() {
        let chatVC = ChatViewController()
        
        var messages: [MessageStruct] = []
        var selfSender = SenderStruct(senderId: "1", displayName: "Dias")
        var secondSender = SenderStruct(senderId: "2", displayName: "Beka")
        
        for i in 0...20 {
            messages.append(MessageStruct(sender: SenderStruct(senderId: "1", displayName: "Dias"), messageId: "asd", sentDate: Date(), kind: .text("Helloasdasdasdasdadasdasda\(i)")))
            messages.append(MessageStruct(sender: secondSender, messageId: "dsa", sentDate: Date(), kind: .text("Hi there\(i)")))
        }
        
        let session = SessionStruct(id: 1, interlocutor: UserStruct(name: "Beka", rating: 5, id: 2), state: .open, type: .outcoming, messages: messages)
        chatVC.setupData(session: session, selfSender: selfSender)
        navigationController?.pushViewController(chatVC, animated: true)
    }
}
