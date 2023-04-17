import Foundation

struct SessionQuery: Codable {
    // MARK: - Properties

    var sessionId: Int
    var sessionUsers: [UserCreateQuery]
    var sessionType: String
    var sessionState: Int
    var sessionOffer: OfferQuery
    var sessionMessages: [MessageQuery]
    var sessionLastMessage: String

    // MARK: - Lifecycle

    init(
        sessionId: Int,
        sessionUsers: [UserCreateQuery],
        sessionType: String,
        sessionState: Int,
        sessionOffer: OfferQuery,
        sessionMessages: [MessageQuery],
        sessionLastMessage: String
    ) {
        self.sessionId = sessionId
        self.sessionUsers = sessionUsers
        self.sessionType = sessionType
        self.sessionState = sessionState
        self.sessionOffer = sessionOffer
        self.sessionMessages = sessionMessages
        self.sessionLastMessage = sessionLastMessage
    }
}

struct MessageQuery: Codable {
    // MARK: - Properties

    var messageId: Int
    var messageDate: String
    var messageText: String
    var messageSender: UserCreateQuery
    var messageSessionId: Int

    // MARK: - Lifecycle

    init(
        messageId: Int,
        messageDate: String,
        messageText: String,
        messageSender: UserCreateQuery,
        messageSessionId: Int
    ) {
        self.messageId = messageId
        self.messageDate = messageDate
        self.messageText = messageText
        self.messageSender = messageSender
        self.messageSessionId = messageSessionId
    }
}
