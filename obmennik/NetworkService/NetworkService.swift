import Foundation

protocol NetworkService: AnyObject {
    
    // User requests
    func createUser(
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    )
    func getCurrencies(
        completion: @escaping (Result<[CurrencyGetQuery], Error>) -> Void
    )
    func getAllOffers(
        userId: Int,
        completion: @escaping (Result<[OfferQuery], Error>) -> Void
    )
    func getUserWatchlist(
        userId: Int,
        completion: @escaping (Result<[OfferQuery], Error>) -> Void
    )
    func renameUser(
        userId: Int,
        newName: String,
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    )
    func userInfo(
        userId: Int,
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    )
    func updateRating(
        userId: Int,
        newRating: Float,
        completion: @escaping (Result<String, Error>) -> Void
    )
    
    // Offer requests
    func getUserOffers(
        userId: Int,
        completion: @escaping (Result<[OfferQuery], Error>) -> Void
    )
    func createOffer(
        offer: OfferCreateQuery,
        completion: @escaping (Result<OfferQuery, Error>) -> Void
    )
    func editOffer(
        offer: OfferEditQuery,
        completion: @escaping (Result<OfferQuery, Error>) -> Void
    )
    func addWatchlist(
        userId: Int,
        offerId: Int,
        completion: @escaping (Result<String, Error>) -> Void
    )
    func removeWatchlist(
        userId: Int,
        offerId: Int,
        completion: @escaping (Result<String, Error>) -> Void
    )
    
    // Session requests
    func getSessionList(
        userId: Int,
        completion: @escaping (Result<[SessionQuery], Error>) -> Void
    )
    func createSession(
        session: SessionCreateQuery,
        completion: @escaping (Result<[String], Error>) -> Void
    )
    func sendMessage(
        message: MessageCreateQuery,
        completion: @escaping (Result<[String], Error>) -> Void
    )
    func closeSession(
        sessionId: Int,
        completion: @escaping (Result<[String], Error>) -> Void
    )
}
