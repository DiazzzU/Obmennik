//
//  DesignElements.swift
//  obmennik
//
//  Created by Dias Ussenov on 21.03.2023.
//

import UIKit


protocol HIG {
    var mediumPadding: CGFloat {get}
    var largePadding: CGFloat {get}
}

extension HIG {
    var mediumPadding: CGFloat { 16 }
    var largePadding: CGFloat { 24 }
}

protocol CurrencyElements {
    var currencyNames: [String] {get}
}

extension CurrencyElements {
    var currencyNames: [String] {
        ["usd", "eu", "kzt", "rub"]
    }
}
