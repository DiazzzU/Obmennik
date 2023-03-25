import UIKit

struct CurrencyStruct {
    var fullName: String
    var shortName: String
    var capitalName: String
    var unicodeCharacter: String
    var logoColor: UIColor
    init(fullName: String, shortName: String, unicodeCharacter: String, logoColor: UIColor) {
        self.fullName = fullName
        self.shortName = shortName
        self.unicodeCharacter = unicodeCharacter
        capitalName = shortName.uppercased()
        self.logoColor = logoColor
    }
}
