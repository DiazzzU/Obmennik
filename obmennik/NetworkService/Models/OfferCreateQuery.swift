import Foundation

struct OfferCreateQuery: Codable {
    // MARK: - Properties

    let fromCurrencyId: Int
    let toCurrencyId: Int
    let fromAmount: Float
    let toAmount: Float
    let exchangeRate: Float
    let creatorId: Int

    // MARK: - Lifecycle

    init(
        fromCurrencyId: Int,
        toCurrencyId: Int,
        fromAmount: Float,
        toAmount: Float,
        exchangeRate: Float,
        creatorId: Int
    ) {
        self.fromCurrencyId = fromCurrencyId
        self.toCurrencyId = toCurrencyId
        self.fromAmount = fromAmount
        self.toAmount = toAmount
        self.exchangeRate = exchangeRate
        self.creatorId = creatorId
    }
}
