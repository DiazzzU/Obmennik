import Foundation

struct OfferEditQuery: Codable {
    // MARK: - Properties

    let offerId: Int
    let fromCurrencyId: Int
    let toCurrencyId: Int
    let fromAmount: Float
    let toAmount: Float
    let exchangeRate: Float
    let creatorId: Int

    // MARK: - Lifecycle

    init(
        offerId: Int,
        fromCurrencyId: Int,
        toCurrencyId: Int,
        fromAmount: Float,
        toAmount: Float,
        exchangeRate: Float,
        creatorId: Int
    ) {
        self.offerId = offerId
        self.fromCurrencyId = fromCurrencyId
        self.toCurrencyId = toCurrencyId
        self.fromAmount = fromAmount
        self.toAmount = toAmount
        self.exchangeRate = exchangeRate
        self.creatorId = creatorId
    }
}
