import UIKit

class OfferViewModels {
    lazy var titleFromLabel: UILabel = {
        return setupLabel(tag: 0, text: "RUB", textColor: .white, font: .boldSystemFont(ofSize: 17))
    }()
    
    lazy var titleToLabel: UILabel = {
        return setupLabel(tag: 8, text: "KZT", textColor: .white, font: .boldSystemFont(ofSize: 17))
    }()
    
    lazy var titleArrow: UILabel = {
        return setupLabel(tag: 7, text: "\u{2794}", textColor: .white, font: .boldSystemFont(ofSize: 16))
    }()
    
    lazy var youPayLabel: UILabel = {
        return setupLabel(tag: 1, text: "You pay", textColor: ColorPalette.secondaryOfferColor, font: .boldSystemFont(ofSize: 16))
    }()
    
    lazy var youGetLabel: UILabel = {
        return setupLabel(tag: 2, text: "You get", textColor: ColorPalette.secondaryOfferColor, font: .boldSystemFont(ofSize: 16))
    }()
    
    lazy var exchangeRateLabel: UILabel = {
        return setupLabel(tag: 3, text: "Exchange rate", textColor: ColorPalette.secondaryOfferColor, font: .boldSystemFont(ofSize: 16))
    }()
    
    lazy var amountFromLabel: UILabel = {
        return setupAmountLabel(tag: 4, amount: 2850, currency: "\u{20B8}")
    }()
    
    lazy var rightArrowAmount: UILabel = {
        return setupLabel(tag: 5, text: "\u{279E}", textColor: .white, font: .boldSystemFont(ofSize: 20))
    }()
    
    lazy var amountToLabel: UILabel = {
        return setupAmountLabel(tag: 6, amount: 500, currency: "\u{20BD}")
    }()
    
    lazy var exchangeRateFrom: UILabel = {
        return setupExchangeRateLabel(tag: 9, amount: 1, currencyName: "RUB")
    }()
    
    lazy var exchangeRateTo: UILabel = {
        return setupExchangeRateLabel(tag: 10, amount: 5.7, currencyName: "KZT")
    }()
    
    lazy var rateChangeButton: UIButton = {
        return setupRateChangeButton(tag: 0)
    }()
    
    lazy var rightArrowRate: UILabel = {
        let rightArrow = setupLabel(tag: 11, text: "\u{27F6}", textColor: .white, font: .boldSystemFont(ofSize: 23))
        return rightArrow
    }()
    
    lazy var leftArrowRate: UILabel = {
        let leftArrow = setupLabel(tag: 12, text: "\u{27F5}", textColor: ColorPalette.secondaryOfferColor, font: .boldSystemFont(ofSize: 23))
        return leftArrow
    }()
    
    lazy var closeButton: UIButton = {
        return setupCloseButton(tag: 1)
    }()
    
    lazy var watchListButton: UIButton = {
        return setupWatchListButton(tag: 2, name: "Add to Watchlist")
    }()
    
    lazy var editButton: UIButton = {
        return setupEditButton(tag: 4)
    }()
    
    lazy var dropButton: UIButton = {
        return setupDropButton(tag: 5)
    }()
    
    lazy var startChatButton: UIButton = {
        return setupStartChatButton(tag: 6)
    }()
    
    // Change button states
    
    func changeRateState(data: OfferStruct) {
        if rightArrowRate.textColor == .white {
            exchangeRateTo.text = (round(data.exchangeRate * 1000) / 1000).description + " " + data.toCurrency.capitalName
            exchangeRateFrom.text = "1.0 " + data.fromCurrency.capitalName
        } else {
            exchangeRateFrom.text = (round(1000 / data.exchangeRate) / 1000).description + " " + data.fromCurrency.capitalName
            exchangeRateTo.text = "1.0 " + data.toCurrency.capitalName
        }
    }
    
    func changeWatchListButtonState() {
        if watchListButton.tag == 2 {
            watchListButton.setTitle("Remove from Watchlist", for: .normal)
            watchListButton.tag = 3
        } else {
            watchListButton.setTitle("Add to Watchlist", for: .normal)
            watchListButton.tag = 2
        }
    }
    
    // Setup
    
    func setupCloseButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(ColorPalette.close, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupRateChangeButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(rightArrowRate)
        button.addSubview(leftArrowRate)
        return button
    }
    
    func setupWatchListButton(tag: Int, name: String) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.setTitle(name, for: .normal)
        button.setTitleColor(ColorPalette.yellow, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = ColorPalette.yellow.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = ColorPalette.backgroundMain
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupEditButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.setTitle("Edit offer", for: .normal)
        button.setTitleColor(ColorPalette.yellow, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = ColorPalette.yellow.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = ColorPalette.backgroundMain
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }
    
    func setupDropButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.setTitle("Drop offer", for: .normal)
        button.setTitleColor(ColorPalette.backgroundMain, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ColorPalette.yellow
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }
    
    func setupStartChatButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.setTitle("Start chatting", for: .normal)
        button.setTitleColor(ColorPalette.backgroundMain, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ColorPalette.yellow
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupExchangeRateLabel(tag: Int, amount: Float, currencyName: String) -> UILabel {
        let label = setupLabel(tag: tag, text: "\(amount) " + currencyName, textColor: .white, font: .boldSystemFont(ofSize: 16))
        return label
    }
    
    func setupAmountLabel(tag: Int, amount: Float, currency: String) -> UILabel {
        return setupLabel(tag: tag, text: "\(amount) " + currency, textColor: .white, font: .boldSystemFont(ofSize: 20))
    }
    
    func setupLabel(tag: Int, text: String, textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.tag = tag
        label.text = text
        label.textColor = textColor
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupDataToTitleLabel(from: String, to: String) {
        titleFromLabel.text = from
        titleToLabel.text = to
    }
    
    func setupDataToAmountFromLabel(amount: Float, currency: String) {
        amountFromLabel.text = "\(amount) " + currency
    }
    
    func setupDataToAmountToLabel(amount: Float, currency: String) {
        amountToLabel.text = "\(amount) " + currency
    }
    
    func setupDataToERFromLabel(amount: Float, currencyName: String) {
        exchangeRateFrom.text = "\(amount) " + currencyName
    }
    
    func setupDataToERToLabel(amount: Float, currencyName: String) {
        exchangeRateTo.text = "\(amount) " + currencyName
    }
    
    func setupData(data: OfferStruct, user: UserStruct) {
        setupDataToTitleLabel(from: data.fromCurrency.capitalName, to: data.toCurrency.capitalName)
        
        setupDataToAmountFromLabel(amount: data.amountToBuy, currency: data.toCurrency.unicodeCharacter)
        setupDataToAmountToLabel(amount: data.amountToSell, currency: data.fromCurrency.unicodeCharacter)
        
        setupDataToERFromLabel(amount: 1, currencyName: data.fromCurrency.capitalName)
        setupDataToERToLabel(amount: data.exchangeRate, currencyName: data.toCurrency.capitalName)
        
        if user.id == data.creator.id {
            editButton.isHidden = false
            dropButton.isHidden = false
            watchListButton.isHidden = true
            startChatButton.isHidden = true
        }
    }
    
    func setupViews(parrent: UIView, data: OfferStruct, user: UserStruct) {
        
        setupData(data: data, user: user)
        
        parrent.addSubview(titleFromLabel)
        parrent.addSubview(titleToLabel)
        parrent.addSubview(titleArrow)
        
        parrent.addSubview(youPayLabel)
        parrent.addSubview(youGetLabel)
        
        parrent.addSubview(amountFromLabel)
        parrent.addSubview(rightArrowAmount)
        parrent.addSubview(amountToLabel)
        
        parrent.addSubview(exchangeRateLabel)
        parrent.addSubview(exchangeRateFrom)
        parrent.addSubview(exchangeRateTo)
        parrent.addSubview(rateChangeButton)
        
        parrent.addSubview(startChatButton)
        parrent.addSubview(watchListButton)
        
        parrent.addSubview(dropButton)
        parrent.addSubview(editButton)
        
        switch data.isInWatchlist {
        case false:
            break
        case true:
            changeWatchListButtonState()
        }
        
        
        print(parrent.frame.size.width / 4)
        NSLayoutConstraint.activate([
            titleArrow.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            titleArrow.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleFromLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleToLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleFromLabel.trailingAnchor.constraint(equalTo: titleArrow.safeAreaLayoutGuide.leadingAnchor, constant: -7),
            titleToLabel.leadingAnchor.constraint(equalTo: titleArrow.safeAreaLayoutGuide.trailingAnchor, constant: 7),
            
            youPayLabel.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: parrent.frame.size.width / 4),
            youPayLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 78),
            
            youGetLabel.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 3 * parrent.frame.size.width / 4),
            youGetLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 78),
            
            amountFromLabel.centerXAnchor.constraint(equalTo: youPayLabel.safeAreaLayoutGuide.centerXAnchor),
            amountFromLabel.topAnchor.constraint(equalTo: youPayLabel.safeAreaLayoutGuide.bottomAnchor, constant: 12),
            
            rightArrowAmount.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            rightArrowAmount.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 109),
            
            amountToLabel.centerXAnchor.constraint(equalTo: youGetLabel.safeAreaLayoutGuide.centerXAnchor),
            amountToLabel.topAnchor.constraint(equalTo: youGetLabel.safeAreaLayoutGuide.bottomAnchor, constant: 12),
            
            exchangeRateLabel.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            exchangeRateLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 203),
            
            rateChangeButton.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            rateChangeButton.topAnchor.constraint(equalTo: exchangeRateLabel.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            rightArrowRate.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            rightArrowRate.topAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.topAnchor, constant: -5),
            leftArrowRate.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            leftArrowRate.topAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.topAnchor, constant: 5),
            
            exchangeRateFrom.topAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.topAnchor, constant: 8),
            exchangeRateFrom.trailingAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.leadingAnchor, constant: -10),
            exchangeRateTo.topAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.topAnchor, constant: 8),
            exchangeRateTo.leadingAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            
            watchListButton.heightAnchor.constraint(equalToConstant: 47),
            watchListButton.bottomAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            watchListButton.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            watchListButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            watchListButton.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            startChatButton.heightAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.heightAnchor),
            startChatButton.bottomAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.topAnchor, constant: -20),
            startChatButton.leadingAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.leadingAnchor),
            startChatButton.trailingAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.trailingAnchor),
            
            editButton.heightAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.heightAnchor),
            editButton.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            editButton.leadingAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.leadingAnchor),
            editButton.trailingAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.trailingAnchor),
            editButton.bottomAnchor.constraint(equalTo: watchListButton.safeAreaLayoutGuide.bottomAnchor),
            
            dropButton.heightAnchor.constraint(equalTo: startChatButton.safeAreaLayoutGuide.heightAnchor),
            dropButton.bottomAnchor.constraint(equalTo: startChatButton.safeAreaLayoutGuide.bottomAnchor),
            dropButton.leadingAnchor.constraint(equalTo: startChatButton.safeAreaLayoutGuide.leadingAnchor),
            dropButton.trailingAnchor.constraint(equalTo: startChatButton.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

