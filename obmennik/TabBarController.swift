import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = ColorPalette.line.cgColor
        tabBar.backgroundColor = ColorPalette.backgroundMain
        tabBar.unselectedItemTintColor = ColorPalette.unselectedElement
        tabBar.tintColor = .white
        tabBar.layer.cornerRadius = 32
    }
    
    func setupTabBar() {
        setupImages()
    }
    
    private func setupImages() {
        guard let viewControllers = viewControllers else {
            return
        }
        
        for i in 0..<viewControllers.count {
            tabBar.items![i].image = UIImage(named: Constants.imageNames[i])
            switch i {
            case 0:
                tabBar.items![i].imageInsets = UIEdgeInsets(top: 10, left: -10, bottom: -6, right: 0)
            case 1:
                tabBar.items![i].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -6, right: -10)
            default:
                print("Error")
                break
            }
        }
    }
}

extension TabBarController {
    enum Constants {
        static let imageNames: [String] = [
            "chart",
            "chat",
        ]
    }
}
