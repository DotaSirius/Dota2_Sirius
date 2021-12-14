import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternatеBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
    }
    
    func setViewControllers(items: [String]) {
        guard let viewControllers = viewControllers else { return }
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground
            tabBar.items![i].image = UIImage(named: items[i])
        }
    }
}
