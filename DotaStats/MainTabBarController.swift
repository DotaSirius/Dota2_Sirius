import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternativeBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
        let viewControllers = [
            CostilViewController(), // TODO: replace with Matches and Players viewControllers.
            SearchPlayerModuleViewController()
        ]
        setViewControllers(viewControllers, animated: false)
        let items = ["matches", "players"]
    }

    func setViewControllers(items: [String]) {
        guard let viewControllers = viewControllers else { return }
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground
            tabBar.items![i].image = UIImage(named: items[i])
        }
    }
}
