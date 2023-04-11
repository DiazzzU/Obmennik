import UIKit
import MessageKit

struct MessageStruct: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct SenderStruct: SenderType {
    var senderId: String
    var displayName: String
}
