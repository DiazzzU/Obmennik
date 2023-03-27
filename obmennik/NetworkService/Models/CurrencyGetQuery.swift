import Foundation

struct CurrencyGetQuery: Codable {
    // MARK: - Properties

    let currencyId: Int
    let currencyName: String
    let currencyCapitalName: String
    let unicodeSymbol: String
    let colorHex: String

    // MARK: - Lifecycle

    init(
        currencyId: Int,
        currencyName: String,
        currencyCapitalName: String,
        unicodeSymbol: String,
        colorHex: String
    ) {
        self.currencyId = currencyId
        self.currencyName = currencyName
        self.currencyCapitalName = currencyCapitalName
        self.unicodeSymbol = unicodeSymbol
        self.colorHex = colorHex
    }
}
