import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabBarController: UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = ColorPalette().secondCell
        tabBar.tabBar.unselectedItemTintColor = ColorPalette().text
        tabBar.tabBar.tintColor = .orange
        let viewControllers = [
            CostilViewController(),
            CostilViewController()
        ]
        tabBar.setViewControllers(viewControllers, animated: false)
        let items = ["matches", "players"]
        for i in 0..<viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette().mainBackground
            tabBar.tabBar.items![i].image = UIImage(named: items[i])
        }
        return tabBar
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: tabBarController)
        window!.rootViewController = nav
        window!.makeKeyAndVisible()
        return true
    }
}
