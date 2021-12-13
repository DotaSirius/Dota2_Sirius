import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternatеBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
        
        let coordinator = Coordinator()
        let network = NetworkServiceImp()
        
        let matchInfoBuilder = MatchInfoModuleBuilder(output: coordinator, networkService: network)
        
        let viewControllers = [
            matchInfoBuilder.viewControler
        ]
        setViewControllers(viewControllers, animated: false)
        let items = ["matches", "players"]
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.backgroundColor = ColorPalette.mainBackground
            tabBar.items![i].image = UIImage(named: items[i])
        }
    }
}
