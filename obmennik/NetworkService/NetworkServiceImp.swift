import Foundation

final class NetworkServiceImp: NetworkService {
    // MARK: - Properties
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - Public
    func createUser(
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createCreateUserRequest(),
            completion: completion
        )
    }
    
    func getCurrencies(
        completion: @escaping (Result<[CurrencyGetQuery], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createGetCurrenciesRequest(),
            completion: completion
        )
    }
    
    func getAllOffers(
        userId: Int,
        completion: @escaping (Result<[OfferQuery], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createGetAllOffersRequest(userId: userId),
            completion: completion
        )
    }
    
    func getUserWatchlist(
        userId: Int,
        completion: @escaping (Result<[OfferQuery], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createGetUserWatchlistRequest(userId: userId),
            completion: completion
        )
    }
    
    func getUserOffers(
        userId: Int,
        completion: @escaping (Result<[OfferQuery], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createGetUserOffersRequest(userId: userId),
            completion: completion
        )
    }
    
    func createOffer(
        offer: OfferCreateQuery,
        completion: @escaping (Result<OfferQuery, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createCreateOfferRequest(offer: offer),
            completion: completion
        )
    }
    
    func editOffer(
        offer: OfferEditQuery,
        completion: @escaping (Result<OfferQuery, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createEditOfferRequest(offer: offer),
            completion: completion
        )
    }
    
    func addWatchlist(
        userId: Int,
        offerId: Int,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createAddWatchlistRequest(userId: userId, offerId: offerId),
            completion: completion
        )
    }
    
    func removeWatchlist(
        userId: Int,
        offerId: Int,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createRemoveWatchlistRequest(userId: userId, offerId: offerId),
            completion: completion
        )
    }
    
    func renameUser(
        userId: Int,
        newName: String,
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createRenameUserRequest(userId: userId, newName: newName),
            completion: completion
        )
    }
    
    func getSessionList(
        userId: Int,
        completion: @escaping (Result<[SessionQuery], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createGetSessionListRequest(userId: userId),
            completion: completion
        )
    }
    
    func createSession(
        session: SessionCreateQuery,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createCreateSessionRequest(session: session),
            completion: completion
        )
    }
    
    func sendMessage(
        message: MessageCreateQuery,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createSendMessageRequest(message: message),
            completion: completion
        )
    }
    
    func closeSession(
        sessionId: Int,
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createCloseSessionRequest(sessionId: sessionId),
            completion: completion
        )
    }
    
    func userInfo(
        userId: Int,
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createUserInfoRequest(userId: userId),
            completion: completion
        )
    }
    
    func updateRating(
        userId: Int,
        newRating: Float,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        networkClient.processRequest(
            request: createUpdateRatingRequest(userId: userId, newRating: newRating),
            completion: completion
        )
    }

    // MARK: - Private

    private func createCreateUserRequest() -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/create/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            httpMethod: .post
        )
    }
    
    private func createGetCurrenciesRequest() -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/currency/getList/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            httpMethod: .get
        )
    }
    
    private func createGetAllOffersRequest(userId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/offer/getList/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)")],
            httpMethod: .get
        )
    }
    
    private func createGetUserWatchlistRequest(userId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/watchlist/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)")],
            httpMethod: .get
        )
    }
    
    private func createGetUserOffersRequest(userId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/getOffers/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)")],
            httpMethod: .get
        )
    }
    
    private func createCreateOfferRequest(offer: OfferCreateQuery) -> HTTPRequest {
        let encoder = JSONEncoder()
        let offerData = try? encoder.encode(offer)
        return HTTPRequest(
            route: "\(Constants.baseurl)/offer/create/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            body: offerData,
            httpMethod: .post
        )
    }
    
    private func createEditOfferRequest(offer: OfferEditQuery) -> HTTPRequest {
        let encoder = JSONEncoder()
        let offerData = try? encoder.encode(offer)
        return HTTPRequest(
            route: "\(Constants.baseurl)/offer/edit/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            body: offerData,
            httpMethod: .post
        )
    }
    
    private func createAddWatchlistRequest(userId: Int, offerId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/addWatchlist/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)"), (key: "offerId", value: "\(offerId)")],
            httpMethod: .post
        )
    }
    
    private func createRemoveWatchlistRequest(userId: Int, offerId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/removeWatchlist/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)"), (key: "offerId", value: "\(offerId)")],
            httpMethod: .post
        )
    }
    
    private func createRenameUserRequest(userId: Int, newName: String) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/rename/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)"), (key: "newName", value: "\(newName)")],
            httpMethod: .post
        )
    }
    
    private func createGetSessionListRequest(userId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/session/list/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)")],
            httpMethod: .get
        )
    }
    
    private func createCreateSessionRequest(session: SessionCreateQuery) -> HTTPRequest {
        let encoder = JSONEncoder()
        let sessionData = try? encoder.encode(session)
        return HTTPRequest(
            route: "\(Constants.baseurl)/session/create/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            body: sessionData,
            httpMethod: .post
        )
    }
    
    private func createSendMessageRequest(message: MessageCreateQuery) -> HTTPRequest {
        let encoder = JSONEncoder()
        let messageData = try? encoder.encode(message)
        return HTTPRequest(
            route: "\(Constants.baseurl)/session/sendMessage/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            body: messageData,
            httpMethod: .post
        )
    }
    
    private func createCloseSessionRequest(sessionId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/session/close/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "sessionId", value: "\(sessionId)")],
            httpMethod: .post
        )
    }
    
    private func createUserInfoRequest(userId: Int) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/info/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)")],
            httpMethod: .get
        )
    }
    
    private func createUpdateRatingRequest(userId: Int, newRating: Float) -> HTTPRequest {
        HTTPRequest(
            route: "\(Constants.baseurl)/user/updateRating/",
            headers: [
                Constants.contentTypeKey: Constants.contentTypeValue
            ],
            queryItems: [(key: "userId", value: "\(userId)"), (key: "newRating", value: "\(newRating)")],
            httpMethod: .post
        )
    }
}

// MARK: - Nested types

extension NetworkServiceImp {
    enum Constants {
        static let baseurl: String = "http://localhost:8000"
        static let contentTypeKey: String = "Content-type"
        static let contentTypeValue: String = "application/json"
    }
}
