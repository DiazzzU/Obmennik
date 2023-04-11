import Foundation

protocol NetworkService: AnyObject {
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
    func renameUser(
        userId: Int,
        newName: String,
        completion: @escaping (Result<UserCreateQuery, Error>) -> Void
    )
}
