import UIKit

final class MainTabBarController: UITabBarController {
    var tabImageNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternativeBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
    }

    func configureTabs() {
        guard let viewControllers = viewControllers else { return }
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground

            tabBar.items![i].image = UIImage(named: tabImageNames[i])
            tabBar.items![i].imageInsets = UIEdgeInsets(top: 55, left: 0, bottom: 35, right: 10)
            tabBar.items![i].title = nil
        }
    }
}
