import UIKit

class ProfileViewModels {
    lazy var backButton: UIButton = {
        return setupBackButton(tag: 0)
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = setupLabel(tag: 0, text: "USER")
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(origin: .zero, size: CGSize(width: titleLabel.textWidth(), height: 30))
        return titleLabel
    }()
    lazy var editNameButton: UIButton = {
        let button = setupEditNameButton(tag: 1)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.frame = CGRect(origin: CGPoint(x: titleLabel.textWidth() + 5, y: 0), size: CGSize(width: 20, height: 20))
        return button
    }()
    lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.addSubview(titleLabel)
        titleView.addSubview(editNameButton)
        titleView.frame = CGRect(origin: .zero, size: CGSize(width: 150, height: 30))
        return titleView
    }()
    
    lazy var ratingView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 35
        view.backgroundColor = ColorPalette.line
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return view
    }()
    lazy var yourRatingLabel: UILabel = {
        let label = setupLabel(tag: 2, text: "Your rating")
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = ColorPalette.secondaryOfferColor
        return label
    }()
    lazy var ratingLabel: UILabel = {
        let label = setupLabel(tag: 1, text: "\u{2606} 5.0")
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var droppedOffersView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 35
        view.backgroundColor = ColorPalette.line
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    lazy var droppedOffersLabel: UILabel = {
        let label = setupLabel(tag: 3, text: "Closeed sessions")
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = ColorPalette.secondaryOfferColor
        return label
    }()
    lazy var droppedOffersNumber: UILabel = {
        let label = setupLabel(tag: 4, text: "0")
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var myOfferTableView: UITableView = {
        let t = UITableView()
        t.tag = 0
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(OfferCellView.self, forCellReuseIdentifier: OfferCellView.identifier)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    lazy var myOffersTabButton: UIButton = {
        let b = UIButton()
        b.setTitle("My offers", for: .normal)
        
        let attributedString = NSMutableAttributedString.init(string: "My offers")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length));
        b.titleLabel?.attributedText = attributedString
        
        b.titleLabel!.font = .boldSystemFont(ofSize: 16)
        b.isSelected = true
        b.setTitleColor(ColorPalette.mainOfferColor, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    func setupLabel(tag: Int, text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.tag = tag
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setupRatingView() {
        ratingView.addSubview(ratingLabel)
        ratingView.addSubview(yourRatingLabel)
    }
    
    func setupDroppedOfferView() {
        droppedOffersView.addSubview(droppedOffersLabel)
        droppedOffersView.addSubview(droppedOffersNumber)
    }
    
    func setupEditNameButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupBackButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupData(user: UserStruct) {
        titleLabel.text = user.name
        droppedOffersNumber.text = "\(user.closedSessions)"
        ratingLabel.text = "\u{2606} " + user.rating.description
    }
    
    func setupLayers(parrent: UIView, user: UserStruct) {
        parrent.addSubview(ratingView)
        parrent.addSubview(droppedOffersView)
        parrent.addSubview(myOffersTabButton)
        parrent.addSubview(myOfferTableView)
        
        setupData(user: user)
        setupRatingView()
        setupDroppedOfferView()
        
        titleView.frame = CGRect(origin: .zero, size: CGSize(width: titleLabel.textWidth() + 25, height: 30))
        titleLabel.frame = CGRect(origin: .zero, size: CGSize(width: titleLabel.textWidth(), height: 30))
        editNameButton.frame = CGRect(origin: CGPoint(x: titleLabel.textWidth() + 5, y: 5), size: CGSize(width: 20, height: 20))
        
        NSLayoutConstraint.activate([
            ratingView.heightAnchor.constraint(equalToConstant: 70),
            ratingView.widthAnchor.constraint(equalToConstant: 160),
            ratingView.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 25),
            ratingView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor, constant: -4),
            
            yourRatingLabel.centerXAnchor.constraint(equalTo: ratingView.safeAreaLayoutGuide.centerXAnchor),
            yourRatingLabel.topAnchor.constraint(equalTo: ratingView.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.safeAreaLayoutGuide.centerXAnchor),
            ratingLabel.topAnchor.constraint(equalTo: ratingView.safeAreaLayoutGuide.topAnchor, constant: 35),
            
            droppedOffersView.heightAnchor.constraint(equalToConstant: 70),
            droppedOffersView.widthAnchor.constraint(equalToConstant: 160),
            droppedOffersView.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 25),
            droppedOffersView.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor, constant: 4),
            
            droppedOffersLabel.centerXAnchor.constraint(equalTo: droppedOffersView.safeAreaLayoutGuide.centerXAnchor),
            droppedOffersLabel.topAnchor.constraint(equalTo: droppedOffersView.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            droppedOffersNumber.centerXAnchor.constraint(equalTo: droppedOffersView.safeAreaLayoutGuide.centerXAnchor),
            droppedOffersNumber.topAnchor.constraint(equalTo: droppedOffersView.safeAreaLayoutGuide.topAnchor, constant: 35),
            
            myOffersTabButton.topAnchor.constraint(equalTo: ratingView.safeAreaLayoutGuide.bottomAnchor, constant: 40),
            myOffersTabButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            myOfferTableView.topAnchor.constraint(equalTo: myOffersTabButton.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            myOfferTableView.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            myOfferTableView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            myOfferTableView.bottomAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
}
