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
    var fromCurrency: CurrencyStruct
    var toCurrency: CurrencyStruct
    var amountToSell: Float
    var amountToBuy: Float
    var exchangeRate: Float
    var creator: CreatorStruct
    
    init(fromCurrency: CurrencyStruct, toCurrency: CurrencyStruct, amountToBuy: Float, amountToSell: Float, creator: CreatorStruct) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amountToBuy = amountToBuy
        self.amountToSell = amountToSell
        self.exchangeRate = amountToBuy / amountToSell
        self.creator = creator
    }
    
    init(fromCurrency: CurrencyStruct, toCurrency: CurrencyStruct, amountToBuy: Float, exchangeRate: Float, creator: CreatorStruct) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amountToBuy = amountToBuy
        self.amountToSell = amountToBuy / exchangeRate
        self.exchangeRate = exchangeRate
        self.creator = creator
    }
    
    init(fromCurrency: CurrencyStruct, toCurrency: CurrencyStruct, amountToSell: Float, exchangeRate: Float, creator: CreatorStruct) {
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.amountToBuy = amountToSell * exchangeRate
        self.amountToSell = amountToSell
        self.exchangeRate = exchangeRate
        self.creator = creator
    }
}
