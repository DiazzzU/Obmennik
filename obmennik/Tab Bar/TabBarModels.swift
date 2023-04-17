import UIKit

class TabBarModels {
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
}
