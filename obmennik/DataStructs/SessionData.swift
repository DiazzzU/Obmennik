import UIKit

struct SessionStruct {
    var id: Int
    var interlocutor: UserStruct
    var state: SessionState
    var type: SessionType
    var messages: [MessageStruct]
    
    enum SessionState {
        case open
        case closed
    }

    enum SessionType {
        case incoming
        case outcoming
    }
}
