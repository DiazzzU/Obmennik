import UIKit

class CreateViewModel {
    lazy var amountToSellField: UITextField = {
        return setupAmountField(tag: 0)
    }()
    
    lazy var amountToBuyField: UITextField = {
        return setupAmountField(tag: 1)
    }()
    
    lazy var currencyToSellField: UITextField = {
        return setupCurrencyField(tag: 2, name: "RUB")
    }()
    
    lazy var currencyToBuyField: UITextField = {
        return setupCurrencyField(tag: 3, name: "KZT")
    }()
    
    lazy var fromRateField: UITextField = {
        return setupRateField(tag: 4)
    }()
    
    lazy var toRateField: UITextField = {
        return setupRateField(tag: 5)
    }()
    
    lazy var titleLabel: UILabel = {
        let label = setupLabel(tag: 3, text: "New offer")
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    lazy var amountToSellLabel: UILabel = {
        return setupLabel(tag: 0, text: "Amount to sell")
    }()
    
    lazy var amountToBuyLabel: UILabel = {
        return setupLabel(tag: 2, text: "Amount to buy")
    }()
    
    lazy var exchangeRateLabel: UILabel = {
        return setupLabel(tag: 1, text: "Exchange rate")
    }()
    
    lazy var fromCurrencyLabel: UILabel = {
        let label = setupLabel(tag: 4, text: "RUB")
        label.textColor = .white
        return label
    }()
    
    lazy var toCurrencyLabel: UILabel = {
        let label = setupLabel(tag: 7, text: "KZT")
        label.textColor = .white
        return label
    }()
    
    lazy var rateChangeButton: UIButton = {
        return setupRateChangeButton(tag: 0)
    }()
    
    lazy var rightArrow: UILabel = {
        let rightArrow = setupLabel(tag: 5, text: "\u{27F6}")
        rightArrow.font = .boldSystemFont(ofSize: 23)
        rightArrow.textColor = .white
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        return rightArrow
    }()
    
    lazy var leftArrow: UILabel = {
        let leftArrow = setupLabel(tag: 6, text: "\u{27F5}")
        leftArrow.textColor = ColorPalette.secondaryOfferColor
        leftArrow.font = .boldSystemFont(ofSize: 23)
        leftArrow.translatesAutoresizingMaskIntoConstraints = false
        return leftArrow
    }()
    
    lazy var createButton: UIButton = {
        return setupCreateButton(tag: 1)
    }()
    
    lazy var closeButton: UIButton = {
        return setupCloseButton(tag: 2)
    }()
    
    func setupCloseButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(ColorPalette.close, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupCreateButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("Create offer", for: .normal)
        button.setTitleColor(ColorPalette.backgroundMain, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ColorPalette.yellow
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupRateChangeButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(rightArrow)
        button.addSubview(leftArrow)
        
        return button
    }
    
    func setupRateField(tag: Int) -> UITextField {
        let textField = UITextField()
        textField.text = "1"
        textField.tag = tag
        textField.font = .boldSystemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorPalette.selectedFilter
        textField.textColor = .white
        textField.clearButtonMode = .never
        return textField
    }
    
    func setupCurrencyField(tag: Int, name: String) -> UITextField {
        let textField = UITextField()
        textField.text = name
        textField.tag = tag
        textField.font = .boldSystemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorPalette.selectedFilter
        textField.textColor = .white
        textField.clearButtonMode = .never
        return textField
    }
    
    func setupLabel(tag: Int, text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.tag = tag
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = ColorPalette.secondaryOfferColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupAmountField(tag: Int) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.tag = tag
        textField.font = .boldSystemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = ColorPalette.selectedFilter
        textField.textColor = .white
        textField.clearButtonMode = .never
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 43))
        textField.leftView = leftView
        textField.leftViewMode = UITextField.ViewMode.always
        return textField
    }
    
    func changeRateState(rateField: UITextField) {
        if rateField.isUserInteractionEnabled {
            rateField.text = "1"
            rateField.backgroundColor = ColorPalette.backgroundMain
            rateField.isUserInteractionEnabled = false
        } else {
            rateField.backgroundColor = ColorPalette.selectedFilter
            rateField.isUserInteractionEnabled = true
        }
    }
    
    func setupViews(parrent: UIView) {
        parrent.addSubview(titleLabel)
        parrent.addSubview(amountToSellLabel)
        parrent.addSubview(amountToSellField)
        parrent.addSubview(currencyToSellField)
        
        parrent.addSubview(exchangeRateLabel)
        parrent.addSubview(fromRateField)
        parrent.addSubview(fromCurrencyLabel)
        parrent.addSubview(toRateField)
        parrent.addSubview(toCurrencyLabel)
        
        parrent.addSubview(amountToBuyLabel)
        parrent.addSubview(amountToBuyField)
        parrent.addSubview(currencyToBuyField)
        parrent.addSubview(rateChangeButton)
        
        parrent.addSubview(createButton)
        parrent.addSubview(closeButton)
        
        changeRateState(rateField: fromRateField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 16.5),
            titleLabel.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
            
            amountToSellField.widthAnchor.constraint(equalToConstant: 244),
            amountToSellField.heightAnchor.constraint(equalToConstant: 43),
            amountToSellField.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 109),
            amountToSellField.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            amountToSellLabel.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            amountToSellLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 78),
            
            currencyToSellField.heightAnchor.constraint(equalToConstant: 43),
            currencyToSellField.leadingAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            currencyToSellField.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.topAnchor),
            currencyToSellField.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -23),
            
            
            exchangeRateLabel.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            exchangeRateLabel.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.bottomAnchor, constant: 50),
            
            fromRateField.widthAnchor.constraint(equalToConstant: 73),
            fromRateField.heightAnchor.constraint(equalToConstant: 43),
            fromRateField.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.bottomAnchor, constant: 81),
            fromRateField.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            fromCurrencyLabel.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.bottomAnchor, constant: 93),
            fromCurrencyLabel.leadingAnchor.constraint(equalTo: fromRateField.safeAreaLayoutGuide.trailingAnchor, constant: 8),
    
            
            rateChangeButton.topAnchor.constraint(equalTo: fromRateField.safeAreaLayoutGuide.topAnchor),
            rateChangeButton.bottomAnchor.constraint(equalTo: fromRateField.safeAreaLayoutGuide.bottomAnchor),
            rateChangeButton.leadingAnchor.constraint(equalTo: fromCurrencyLabel.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            rightArrow.topAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.topAnchor, constant: 0),
            leftArrow.topAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            
            toRateField.widthAnchor.constraint(equalToConstant: 73),
            toRateField.heightAnchor.constraint(equalToConstant: 43),
            toRateField.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.bottomAnchor, constant: 81),
            toRateField.leadingAnchor.constraint(equalTo: rateChangeButton.safeAreaLayoutGuide.trailingAnchor, constant: 18),
            
            toCurrencyLabel.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.bottomAnchor, constant: 93),
            toCurrencyLabel.leadingAnchor.constraint(equalTo: toRateField.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            
            
            amountToBuyField.widthAnchor.constraint(equalToConstant: 244),
            amountToBuyField.heightAnchor.constraint(equalToConstant: 43),
            amountToBuyField.topAnchor.constraint(equalTo: amountToSellField.safeAreaLayoutGuide.bottomAnchor, constant: 205),
            amountToBuyField.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            amountToBuyLabel.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            amountToBuyLabel.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 326),
            
            currencyToBuyField.heightAnchor.constraint(equalToConstant: 43),
            currencyToBuyField.leadingAnchor.constraint(equalTo: amountToBuyField.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            currencyToBuyField.topAnchor.constraint(equalTo: amountToBuyField.safeAreaLayoutGuide.topAnchor),
            currencyToBuyField.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -23),
            
            
            createButton.heightAnchor.constraint(equalToConstant: 47),
            createButton.bottomAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            createButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            createButton.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            closeButton.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
        ])
    }
}
