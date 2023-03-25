import UIKit

class OfferCellView: UITableViewCell {
    static let identifier = "offerCellId";
    lazy var fromCurrency: UILabel = {
        let label = UILabel()
        label.text = "RUB"
        label.textColor = ColorPalette.mainOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rightArrow: UILabel = {
        let label = UILabel()
        label.text = "\u{2794}"
        label.textColor = ColorPalette.mainOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var toCurrency: UILabel = {
        let label = UILabel()
        label.text = "KZT"
        label.textColor = ColorPalette.mainOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var logoView: UILabel = {
        let logoView = UILabel()
        logoView.text = "\u{20BD}"
        logoView.textColor = ColorPalette.mainOfferColor
        logoView.font = .boldSystemFont(ofSize: 18)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.textAlignment = .center
        return logoView
    }()
    lazy var logoCircleView: UIImageView = {
        let logoCircleView = UIImageView()
        logoCircleView.image = UIColor.blue.image(CGSize(width: 32, height: 32))
        logoCircleView.translatesAutoresizingMaskIntoConstraints = false
        logoCircleView.layer.masksToBounds = false
        logoCircleView.layer.cornerRadius = 16
        logoCircleView.clipsToBounds = true
        return logoCircleView
    }()
    lazy var amountView: UILabel = {
        let label = UILabel()
        label.text = "10000"
        label.textColor = ColorPalette.mainOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var fromSymbolView: UILabel = {
        let label = UILabel()
        label.text = "\u{20BD}"
        label.textColor = ColorPalette.mainOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var toSymbolView: UILabel = {
        let label = UILabel()
        label.text = "\u{20B8}"
        label.textColor = ColorPalette.secondaryOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var exchangeRateView: UILabel = {
        let label = UILabel()
        label.text = "5.7"
        label.textColor = ColorPalette.secondaryOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var userNameView: UILabel = {
        let label = UILabel()
        label.text = "Dias"
        label.textColor = ColorPalette.secondaryOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var userRating: UILabel = {
        let label = UILabel()
        label.text = "\u{2606}5"
        label.textColor = ColorPalette.secondaryOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpData(data: OfferStruct) {
        setFromCurrency(currencyName: data.fromCurrency.capitalName)
        setToCurrency(currencyName: data.toCurrency.capitalName)
        setLogoView(unicodeString: data.fromCurrency.unicodeCharacter)
        setLogoColor(logoColor: data.fromCurrency.logoColor)
        setAmountView(amount: data.amountToSell)
        setFromSymbolView(fromSymbol: data.fromCurrency.unicodeCharacter)
        setToSymbolView(toSymbol: data.toCurrency.unicodeCharacter)
        setExchangeRateView(exchangeRate: data.exchangeRate)
        setUserName(name: data.creator.name)
        setUserRating(rating: data.creator.rating)
    }
    
    func setFromCurrency(currencyName: String) {
        fromCurrency.text = currencyName
    }
    
    func setToCurrency(currencyName: String) {
        toCurrency.text = currencyName
    }
    
    func setLogoView(unicodeString: String) {
        logoView.text = unicodeString
    }
    
    func setLogoColor(logoColor: UIColor) {
        logoCircleView.image = logoColor.image(CGSize(width: 32, height: 32))
    }
    
    func setAmountView(amount: Float) {
        amountView.text = amount.description
    }
    
    func setFromSymbolView(fromSymbol: String) {
        fromSymbolView.text = fromSymbol
    }
    
    func setToSymbolView(toSymbol: String) {
        toSymbolView.text = toSymbol
    }
    
    func setExchangeRateView(exchangeRate: Float) {
        exchangeRateView.text = exchangeRate.description
    }
    
    func setUserName(name: String) {
        userNameView.text = name
    }
    
    func setUserRating(rating: Float) {
        userRating.text = "\u{2606}" + rating.description
    }
    
    func setupCell(data: OfferStruct) {
        self.addSubview(logoView)
        self.insertSubview(logoCircleView, belowSubview: logoView)
        self.addSubview(fromCurrency)
        self.addSubview(rightArrow)
        self.addSubview(toCurrency)
        self.addSubview(amountView)
        self.addSubview(fromSymbolView)
        self.addSubview(exchangeRateView)
        self.addSubview(toSymbolView)
        self.addSubview(userNameView)
        self.addSubview(userRating)
        
        setUpData(data: data)
        
        NSLayoutConstraint.activate([

            logoView.widthAnchor.constraint(equalToConstant: 20),
            logoView.heightAnchor.constraint(equalToConstant: 20),
            logoView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 22),
            logoView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            logoCircleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoCircleView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            fromCurrency.leadingAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.trailingAnchor, constant: 14),
            fromCurrency.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            rightArrow.leadingAnchor.constraint(equalTo: fromCurrency.safeAreaLayoutGuide.trailingAnchor, constant: 6),
            rightArrow.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            toCurrency.leadingAnchor.constraint(equalTo: rightArrow.safeAreaLayoutGuide.trailingAnchor, constant: 6),
            toCurrency.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            
            amountView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            amountView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -41),
            fromSymbolView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            fromSymbolView.leadingAnchor.constraint(equalTo: amountView.safeAreaLayoutGuide.trailingAnchor, constant: 4),
            
            exchangeRateView.topAnchor.constraint(equalTo: amountView.safeAreaLayoutGuide.bottomAnchor, constant: 2),
            exchangeRateView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -39),
            toSymbolView.topAnchor.constraint(equalTo: amountView.safeAreaLayoutGuide.bottomAnchor, constant: 2),
            toSymbolView.leadingAnchor.constraint(equalTo: exchangeRateView.safeAreaLayoutGuide.trailingAnchor, constant: 4),
            
            userNameView.leadingAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.trailingAnchor, constant: 14),
            userNameView.topAnchor.constraint(equalTo: fromCurrency.safeAreaLayoutGuide.bottomAnchor, constant: 2.5),
            userRating.leadingAnchor.constraint(equalTo: userNameView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            userRating.topAnchor.constraint(equalTo: fromCurrency.safeAreaLayoutGuide.bottomAnchor, constant: 2.5),
        ])
    }
}
