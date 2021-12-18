import UIKit

final class MainTabBarController: UITabBarController {
    var tabImageNames: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternativeBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
        tabBar.barTintColor = ColorPalette.alternativeBackground
    }

    func configureTabs() {
        guard let viewControllers = viewControllers else {
            return
        }
        for i in 0..<viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground

            tabBar.items![i].image = UIImage(named: tabImageNames[i])

            switch i {
            case 0:
                tabBar.items![i].imageInsets = UIEdgeInsets(top: 10, left: 5, bottom: -5, right: -5)
            default:
                tabBar.items![i].imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -5, right: 0)
            }

            tabBar.items![i].title = nil
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}
