import Foundation

struct SessionCreateQuery: Codable {
    // MARK: - Properties

    var ownerId: Int
    var userIds: [Int]
    var offerId: Int
    var initialMessage: MessageCreateQuery

    // MARK: - Lifecycle

    init(
        ownerId: Int,
        userIds: [Int],
        offerId: Int,
        initialMessage: MessageCreateQuery
    ) {
        self.ownerId = ownerId
        self.userIds = userIds
        self.offerId = offerId
        self.initialMessage = initialMessage
    }
}

struct MessageCreateQuery: Codable {
    // MARK: - Properties

    var senderId: Int
    var sessionId: Int
    var messageDate: String
    var messageText: String

    // MARK: - Lifecycle

    init(
        senderId: Int,
        sessionId: Int,
        messageDate: String,
        messageText: String
    ) {
        self.sessionId = sessionId
        self.messageDate = messageDate
        self.messageText = messageText
        self.senderId = senderId
    }
}
