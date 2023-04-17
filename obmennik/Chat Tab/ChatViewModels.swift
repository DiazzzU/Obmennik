import UIKit

class ChatViewModels {
    lazy var backButton: UIButton = {
        return setupBackButton(tag: 0)
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        //button.overrideUserInterfaceStyle = .dark
        button.setImage(UIImage(named: "menu"), for: .normal)
        //button.showsMenuAsPrimaryAction = true
        //button.menu = menuView
        return button
    }()
    
    lazy var menuView: UIMenu = {
        let menu = UIMenu(children: [offerAction, closeSessionAction])
        menu.accessibilityFrame = CGRect(x: 0, y: 0, width: 50, height: 100)
        return menu
    }()
    
    lazy var offerAction: UIAction = {
        let offerAction = UIAction(title: "Offer", attributes: [], state: .off) { action in
            print("offer")
        }
        return offerAction
    }()
    
    lazy var closeSessionAction: UIAction = {
        let closeSessionAction = UIAction(title: "Close session", attributes: [.destructive], state: .off) { action in
            print("close session")
        }
        return closeSessionAction
    }()
    
    lazy var rateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = ColorPalette.backgroundMain
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var rateTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let text1 = UILabel()
        let text2 = UILabel()
        
        text1.text = "The session was closed."
        text1.textColor = .white
        text1.font = .boldSystemFont(ofSize: 16)
        text1.translatesAutoresizingMaskIntoConstraints = false
        
        text2.text = "Please, rate the user"
        text2.textColor = .white
        text2.font = .boldSystemFont(ofSize: 16)
        text2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(text1)
        view.addSubview(text2)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 280),
            view.heightAnchor.constraint(equalToConstant: 38),
            text1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            text2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            text1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            text2.topAnchor.constraint(equalTo: text1.safeAreaLayoutGuide.bottomAnchor, constant: 2)
        ])
        return view
    }()
    
    lazy var stars: [UIButton] = {
        var stars: [UIButton] = []
        for i in 0..<5 {
            stars.append(setupStar(tag: i))
        }
        return stars
    }()
    
    lazy var starDecsription: UILabel = {
        let label = UILabel()
        label.text = "User deceived me"
        label.textColor = ColorPalette.secondaryOfferColor
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rate", for: .normal)
        button.setTitleColor(ColorPalette.backgroundMain, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = ColorPalette.yellow
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupStar(tag: Int) -> UIButton {
        let star = UIButton()
        star.setImage(UIImage(named: "unselectedStar"), for: .normal)
        star.translatesAutoresizingMaskIntoConstraints = false
        star.tag = tag
        return star
    }
    
    func changeStarState(tag: Int) {
        stars[tag].setImage(UIImage(named: "selectedStar"), for: .normal)
    }
    
    func resetStarState(tag: Int) {
        stars[tag].setImage(UIImage(named: "unselectedStar"), for: .normal)
    }
    
    func setupBackButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func setupRateView() {
        rateView.addSubview(rateTitleView)
        for star in stars {
            rateView.addSubview(star)
        }
        rateView.addSubview(starDecsription)
        rateView.addSubview(rateButton)
        
        NSLayoutConstraint.activate([
            rateTitleView.topAnchor.constraint(equalTo: rateView.safeAreaLayoutGuide.topAnchor, constant: 14),
            rateTitleView.centerXAnchor.constraint(equalTo: rateView.safeAreaLayoutGuide.centerXAnchor),
            
            stars[2].centerXAnchor.constraint(equalTo: rateView.safeAreaLayoutGuide.centerXAnchor),
            stars[2].topAnchor.constraint(equalTo: rateTitleView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            stars[1].trailingAnchor.constraint(equalTo: stars[2].safeAreaLayoutGuide.leadingAnchor, constant: -5),
            stars[1].topAnchor.constraint(equalTo: rateTitleView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            stars[0].trailingAnchor.constraint(equalTo: stars[1].safeAreaLayoutGuide.leadingAnchor, constant: -5),
            stars[0].topAnchor.constraint(equalTo: rateTitleView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            stars[3].leadingAnchor.constraint(equalTo: stars[2].safeAreaLayoutGuide.trailingAnchor, constant: 5),
            stars[3].topAnchor.constraint(equalTo: rateTitleView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            stars[4].leadingAnchor.constraint(equalTo: stars[3].safeAreaLayoutGuide.trailingAnchor, constant: 5),
            stars[4].topAnchor.constraint(equalTo: rateTitleView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            
            starDecsription.centerXAnchor.constraint(equalTo: rateView.centerXAnchor),
            starDecsription.topAnchor.constraint(equalTo: stars[2].safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            rateButton.widthAnchor.constraint(equalToConstant: 200),
            rateButton.heightAnchor.constraint(equalToConstant: 47),
            rateButton.centerXAnchor.constraint(equalTo: rateView.safeAreaLayoutGuide.centerXAnchor),
            rateButton.topAnchor.constraint(equalTo: starDecsription.safeAreaLayoutGuide.bottomAnchor, constant: 20)

        ])
    }
    
    func setupLayers(parrent: UIView) {
        setupRateView()
        parrent.addSubview(rateView)
        NSLayoutConstraint.activate([
            rateView.widthAnchor.constraint(equalToConstant: 325),
            rateView.heightAnchor.constraint(equalToConstant: 207),
            rateView.bottomAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            rateView.centerXAnchor.constraint(equalTo: parrent.safeAreaLayoutGuide.centerXAnchor),
           
        ])
    }
}
