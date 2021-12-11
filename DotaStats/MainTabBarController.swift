import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        tabBar.backgroundColor = ColorPalette.alternatеBackgroundColor
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = .orange
        let viewControllers = [
            CostilViewController(), // TODO: replace with Matches and Players viewControllers.
            CostilViewController()
        ]
        setViewControllers(viewControllers, animated: false)
        let items = ["matches", "players"]
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground
            tabBar.items![i].image = UIImage(named: items[i])
        }
    }
}
