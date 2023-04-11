import Foundation

struct OfferQuery: Codable {
    // MARK: - Properties

    let offerId: Int
    let fromCurrencyId: Int
    let toCurrencyId: Int
    let fromAmount: Float
    let toAmount: Float
    let exchangeRate: Float
    let creator: UserCreateQuery
    let isOnWatchlist: Bool

    // MARK: - Lifecycle

    init(
        offerId: Int,
        fromCurrencyId: Int,
        toCurrencyId: Int,
        fromAmount: Float,
        toAmount: Float,
        exchangeRate: Float,
        creator: UserCreateQuery,
        isOnWatchlist: Bool
    ) {
        self.offerId = offerId
        self.fromCurrencyId = fromCurrencyId
        self.toCurrencyId = toCurrencyId
        self.fromAmount = fromAmount
        self.toAmount = toAmount
        self.exchangeRate = exchangeRate
        self.creator = creator
        self.isOnWatchlist = isOnWatchlist
    }
}
