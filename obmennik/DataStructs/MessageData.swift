import UIKit
import MessageKit

struct MessageStruct: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    var sessionId: Int
    
    init(message: MessageQuery) {
        self.sender = SenderStruct(user: message.messageSender)
        self.messageId = "\(message.messageId)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.sentDate = dateFormatter.date(from: message.messageDate)!
        self.kind = MessageKind.text(message.messageText)
        self.sessionId = message.messageSessionId
    }
    
    init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind, sessionId: Int) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.sessionId = sessionId
    }
}

struct SenderStruct: SenderType {
    var senderId: String
    var displayName: String
    
    init(user: UserCreateQuery) {
        self.senderId = "\(user.user_id)"
        self.displayName = user.user_name
    }
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}
