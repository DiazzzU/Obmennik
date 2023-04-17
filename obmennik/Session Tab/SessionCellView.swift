import UIKit

class SessionCellView: UITableViewCell {
    static let identifier = "sessionCellId";
    
    lazy var userLabel: UILabel = {
        let label = UILabel()
        label.text = "User \u{2606}5"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1000 \u{20B8}"
        label.textColor = ColorPalette.secondaryOfferColor
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var logoView: UILabel = {
        let logoView = UILabel()
        logoView.text = "\u{20BD}"
        logoView.textColor = ColorPalette.mainOfferColor
        logoView.font = .boldSystemFont(ofSize: 25)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.textAlignment = .center
        return logoView
    }()
    lazy var logoCircleView: UIImageView = {
        let logoCircleView = UIImageView()
        logoCircleView.image = UIColor.blue.image(CGSize(width: 32, height: 32))
        logoCircleView.translatesAutoresizingMaskIntoConstraints = false
        logoCircleView.layer.masksToBounds = false
        logoCircleView.layer.cornerRadius = 20
        logoCircleView.clipsToBounds = true
        return logoCircleView
    }()
    
    func setUpData(data: SessionStruct) {
        setLogoView(unicodeString: data.offer.fromCurrency.unicodeCharacter)
        setLogoColor(logoColor: data.offer.fromCurrency.logoColor)
        setAmountLabel(amount: data.offer.amountToSell, symbol: data.offer.fromCurrency.unicodeCharacter)
        setUserLabel(userName: data.interlocutor.name, userRating: data.interlocutor.rating)
    }
    
    func setLogoView(unicodeString: String) {
        logoView.text = unicodeString
    }
    
    func setLogoColor(logoColor: UIColor) {
        logoCircleView.image = logoColor.image(CGSize(width: 32, height: 32))
    }
    
    func setAmountLabel(amount: Float, symbol: String) {
        amountLabel.text = amount.description + " " + symbol
    }
    
    func setUserLabel(userName: String, userRating: Float) {
        userLabel.text = userName + " \u{2606}\(userRating)"
    }

    
    func setupCell(data: SessionStruct) {
        self.addSubview(logoView)
        self.insertSubview(logoCircleView, belowSubview: logoView)
        self.addSubview(userLabel)
        self.addSubview(amountLabel)
        
        setUpData(data: data)
        
        NSLayoutConstraint.activate([

            logoView.widthAnchor.constraint(equalToConstant: 40),
            logoView.heightAnchor.constraint(equalToConstant: 40),
            logoView.centerXAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.centerYAnchor),
            
            logoCircleView.widthAnchor.constraint(equalToConstant: 40),
            logoCircleView.heightAnchor.constraint(equalToConstant: 40),
            logoCircleView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            logoCircleView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            userLabel.leadingAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.trailingAnchor, constant: 14),
            userLabel.topAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            amountLabel.leadingAnchor.constraint(equalTo: logoCircleView.safeAreaLayoutGuide.trailingAnchor, constant: 14),
            amountLabel.topAnchor.constraint(equalTo: userLabel.safeAreaLayoutGuide.bottomAnchor, constant: 2)
            
        ])
        
    }
}
