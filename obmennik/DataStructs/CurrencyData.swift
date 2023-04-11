import UIKit

struct CurrencyStruct {
    var currencyId: Int
    var fullName: String
    var shortName: String
    var capitalName: String
    var unicodeCharacter: String
    var logoColor: UIColor
    init(currencyId: Int, fullName: String, shortName: String, unicodeCharacter: String, logoColor: UIColor) {
        self.currencyId = currencyId
        self.fullName = fullName
        self.shortName = shortName
        self.unicodeCharacter = unicodeCharacter
        self.capitalName = shortName.uppercased()
        self.logoColor = logoColor
    }
    static func getUnicodeCharacter(unicodeSymbol: String) -> String {
        guard let floatValue = Float("0x" + unicodeSymbol) else {
            print("Error parsing unicode symbol")
            return "Q"
        }
        return String(UnicodeScalar(UInt32(floatValue))!)
    }
}
