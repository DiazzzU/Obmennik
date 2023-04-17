import UIKit

struct CreatorStruct {
    var name: String
    var rating: Float
    
    init(name: String, rating: Float) {
        self.name = name
        self.rating = rating
    }
}


struct OfferStruct {
    var offerId: Int
    var fromCurrency: CurrencyStruct
    var toCurrency: CurrencyStruct
    var amountToSell: Float
    var amountToBuy: Float
    var exchangeRate: Float
    var creator: UserStruct
    var isInWatchlist: Bool
    
    init(offerId: Int, fromCurrency: CurrencyStruct, toCurrency: CurrencyStruct, amountToBuy: Float, amountToSell: Float, creator: UserStruct, isInWatchList: Bool) {
        self.offerId = offerId
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amountToBuy = amountToBuy
        self.amountToSell = amountToSell
        self.exchangeRate = amountToBuy / amountToSell
        self.creator = creator
        self.isInWatchlist = isInWatchList
    }
    
    init(offerId: Int, fromCurrency: CurrencyStruct, toCurrency: CurrencyStruct, amountToBuy: Float, exchangeRate: Float, creator: UserStruct, isInWatchList: Bool) {
        self.offerId = offerId
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amountToBuy = amountToBuy
        self.amountToSell = amountToBuy / exchangeRate
        self.exchangeRate = exchangeRate
        self.creator = creator
        self.isInWatchlist = isInWatchList
    }
    
    init(offerId: Int, fromCurrency: CurrencyStruct, toCurrency: CurrencyStruct, amountToSell: Float, exchangeRate: Float, creator: UserStruct, isInWatchList: Bool) {
        self.offerId = offerId
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amountToBuy = amountToSell * exchangeRate
        self.amountToSell = amountToSell
        self.exchangeRate = exchangeRate
        self.creator = creator
        self.isInWatchlist = isInWatchList
    }
    
    init(offer: OfferQuery, currencies: [CurrencyStruct]) {
        var fromCurrency: CurrencyStruct? = nil
        var toCurrency: CurrencyStruct? = nil
        for currency in currencies {
            if currency.currencyId == offer.fromCurrencyId {
                fromCurrency = currency
            }
            if currency.currencyId == offer.toCurrencyId {
                toCurrency = currency
            }
        }
        
        self.offerId = offer.offerId
        self.fromCurrency = fromCurrency!
        self.toCurrency = toCurrency!
        self.amountToBuy = offer.toAmount
        self.amountToSell = offer.fromAmount
        self.exchangeRate = offer.exchangeRate
        self.creator = UserStruct(data: offer.creator)
        self.isInWatchlist = offer.isOnWatchlist
    }
}
