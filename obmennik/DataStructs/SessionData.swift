import UIKit

struct SessionStruct {
    var id: Int
    var interlocutor: UserStruct
    var state: SessionState
    var type: SessionType
    var messages: [MessageStruct]
    var offer: OfferStruct
    var lastMessage: Date
    
    enum SessionState {
        case open
        case closed
    }

    enum SessionType {
        case incoming
        case outcoming
    }
    
    init(session: SessionQuery, currencies: [CurrencyStruct]) {
        self.id = session.sessionId
        self.interlocutor = UserStruct(data: session.sessionUsers[0])
        self.state = session.sessionState == 1 ? .open : .closed
        self.type = session.sessionType == "incoming" ? .incoming : .outcoming
        self.offer = OfferStruct(offer: session.sessionOffer, currencies: currencies)
        
        self.messages = []
        for message in session.sessionMessages {
            self.messages.append(MessageStruct(message: message))
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.lastMessage = dateFormatter.date(from: session.sessionLastMessage)!
    }
    
    init(id: Int, interlocutor: UserStruct, state: SessionState, type: SessionType, messages: [MessageStruct], offer: OfferStruct, lastMessage: Date) {
        self.id = id
        self.interlocutor = interlocutor
        self.state = state
        self.type = type
        self.messages = messages
        self.offer = offer
        self.lastMessage = lastMessage
    }
}
