import UIKit

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        // Your middle tab bar item index.
        // In my case it's 1.
        if selectedIndex == 2 {
            return false
        }
        
        return true
    }
}
