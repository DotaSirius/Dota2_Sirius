import UIKit

final class MainTabBarController: UITabBarController {
    var tabImageNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternativeBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
    }

    func configurateTabs() {
        guard let viewControllers = viewControllers else { return }
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground
            tabBar.items![i].image = UIImage(named: tabImageNames[i])
        }
    }
}
