import UIKit


class HomeViewModels: HIG {
    lazy var profileButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(named: "userProfileLogo"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        return b
    }()
    
    lazy var searchButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(named: "search"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 12
        return b
    }()
    
    lazy var offerTableView: UITableView = {
        let t = UITableView()
        t.tag = 1
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(OfferCellView.self, forCellReuseIdentifier: OfferCellView.identifier)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    lazy var watchlistTableView: UITableView = {
        let t = UITableView()
        t.tag = 2
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(OfferCellView.self, forCellReuseIdentifier: OfferCellView.identifier)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isHidden = true
        return t
    }()
    
    lazy var watchlistTabButton: UIButton = {
        let b = UIButton()
        b.setTitle("Watchlist", for: .normal)
        b.titleLabel!.font = .boldSystemFont(ofSize: 20)
        b.titleLabel?.tintColor = ColorPalette.mainOfferColor
        b.setTitleColor(ColorPalette.secondaryOfferColor, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var offerTabButton: UIButton = {
        let b = UIButton()
        b.setTitle("Offers", for: .normal)
        
        let attributedString = NSMutableAttributedString.init(string: "Offers")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length));
        b.titleLabel?.attributedText = attributedString
        
        b.titleLabel!.font = .boldSystemFont(ofSize: 20)
        b.isSelected = true
        b.setTitleColor(ColorPalette.mainOfferColor, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    lazy var filterCollectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FilterCellView.self, forCellWithReuseIdentifier: FilterCellView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    func changeOfferButtonState(offerButton: UIButton) {
        switch offerButton.isSelected {
        case true:
            offerButton.isSelected = false
            offerButton.setTitleColor(ColorPalette.secondaryOfferColor, for: .normal)
            offerButton.titleLabel?.attributedText = nil
        case false:
            offerButton.isSelected = true
            offerButton.setTitleColor(ColorPalette.mainOfferColor, for: .normal)
            
            let attributedString = NSMutableAttributedString.init(string: "Offers")
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length));
            offerButton.titleLabel?.attributedText = attributedString
        }
    }
    func changeWatchlistButtonState(watchlistButton: UIButton) {
        switch watchlistButton.isSelected {
        case true:
            watchlistButton.isSelected = false
            watchlistButton.setTitleColor(ColorPalette.secondaryOfferColor, for: .normal)
            watchlistButton.titleLabel?.attributedText = nil
        case false:
            watchlistButton.isSelected = true
            watchlistButton.setTitleColor(ColorPalette.mainOfferColor, for: .normal)
            
            let attributedString = NSMutableAttributedString.init(string: "Watchlist")
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length));
            watchlistButton.titleLabel?.attributedText = attributedString
        }
    }
    
    func setupLayers(parrent: UIView) {
        //parrent.addSubview(profileButton)
        //parrent.addSubview(searchButton)
        parrent.addSubview(offerTableView)
        parrent.addSubview(watchlistTabButton)
        parrent.addSubview(offerTabButton)
        parrent.addSubview(filterCollectionView)
        parrent.addSubview(watchlistTableView)
        
        
        
        NSLayoutConstraint.activate([
            profileButton.widthAnchor.constraint(equalToConstant: 24),
            profileButton.heightAnchor.constraint(equalToConstant: 24),
            
            //searchButton.widthAnchor.constraint(equalToConstant: 24),
            //searchButton.heightAnchor.constraint(equalToConstant: 24),
            //searchButton.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 2),
            //searchButton.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            
            offerTableView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: 0),
            offerTableView.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            offerTableView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            offerTableView.bottomAnchor.constraint(equalTo: parrent.bottomAnchor),
            
            watchlistTableView.topAnchor.constraint(equalTo: filterCollectionView.topAnchor, constant: 10),
            watchlistTableView.bottomAnchor.constraint(equalTo: parrent.bottomAnchor),
            watchlistTableView.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            watchlistTableView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            watchlistTabButton.widthAnchor.constraint(equalToConstant: 87),
            watchlistTabButton.heightAnchor.constraint(equalToConstant: 24),
            watchlistTabButton.topAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.topAnchor, constant: 30),
            watchlistTabButton.leadingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            offerTabButton.widthAnchor.constraint(equalToConstant: 60),
            offerTabButton.heightAnchor.constraint(equalToConstant: 24),
            offerTabButton.topAnchor.constraint(equalTo: watchlistTabButton.safeAreaLayoutGuide.topAnchor),
            offerTabButton.leadingAnchor.constraint(equalTo: watchlistTabButton.safeAreaLayoutGuide.trailingAnchor, constant: 20),
            
            filterCollectionView.heightAnchor.constraint(equalToConstant: 50),
            filterCollectionView.topAnchor.constraint(equalTo: offerTabButton.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            filterCollectionView.leadingAnchor.constraint(equalTo: watchlistTabButton.leadingAnchor, constant: -10),
            filterCollectionView.trailingAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            filterCollectionView.bottomAnchor.constraint(equalTo: offerTableView.safeAreaLayoutGuide.topAnchor, constant: -10),
        ])
    }
    
}
