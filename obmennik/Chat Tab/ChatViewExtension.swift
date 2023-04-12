import UIKit
import MessageKit
import InputBarAccessoryView

extension ChatViewController: MessagesDataSource {
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageTimestampLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        return NSAttributedString(
            string: "HERE",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                NSAttributedString.Key.foregroundColor: ColorPalette.secondaryOfferColor,
            ]
        )
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? ColorPalette.selectedFilter : ColorPalette.line
    }
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        if messages.count == indexPath.section + 1 || messages[indexPath.section + 1].sender.senderId != message.sender.senderId {
            return .bubbleTail(corner, .pointedEdge)
        } else {
            return .bubble
        }
    }
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return .white
    }
}

extension ChatViewController: MessageCellDelegate {
    func didTapBackground(in cell: MessageCollectionViewCell) {
        didTapView()
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = MessageStruct(sender: selfSender, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text))
        insertMessage(message: message)
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize? {
        return .zero
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.frame = CGRect(origin: .zero, size: CGSize(width: 0, height: 0))
    }
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if (isNextMessageSenderSame(indexPath: indexPath) && isNextMessageMinutesSame(indexPath: indexPath)) || !isFromCurrentSender(message: message) {
            return 0
        }
        return 10
    }

    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let message = messages[indexPath.section]
        let status = message.sentDate.getTime()
        return NSAttributedString(
            string: status,
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                NSAttributedString.Key.foregroundColor: ColorPalette.secondaryOfferColor,
            ]
        )
    }
    
    func messageBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment? {
        if isFromCurrentSender(message: message) {
            return LabelAlignment(textAlignment: .right, textInsets: UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 10))
        }
        return nil
    }
    
    func isNextMessageMinutesSame(indexPath: IndexPath) -> Bool {
        if messages.count == indexPath.section + 1 {
            return false
        }
        let minutes1 = Calendar.current.component(.minute, from: messages[indexPath.section].sentDate)
        let minutes2 = Calendar.current.component(.minute, from: messages[indexPath.section + 1].sentDate)
        if minutes1 != minutes2 {
            return false
        }
        return true
    }
    
    func isNextMessageSenderSame(indexPath: IndexPath) -> Bool {
        if messages.count == indexPath.section + 1 || messages[indexPath.section + 1].sender.senderId !=  messages[indexPath.section].sender.senderId {
            return false
        } else {
            return true
        }
    }
}

extension Date {
    func getTime() -> String {
        let hours   = (Calendar.current.component(.hour, from: self))
        let minutes = (Calendar.current.component(.minute, from: self))
        return (hours / 10 == 0 ? "0\(hours)" : "\(hours)") + ":" + (minutes / 10 == 0 ? "0\(minutes)" : "\(minutes)")
    }
}
