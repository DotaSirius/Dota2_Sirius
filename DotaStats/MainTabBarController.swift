import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = ColorPalette.alternatеBackground
        tabBar.unselectedItemTintColor = ColorPalette.text
        tabBar.tintColor = ColorPalette.accent
        let module = MatchesModuleBuilder(
            output: AppCoordinator(),
            matchesService: MatchesServiceImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            )
        )
        let viewControllers = [
            // TODO: replace with Matches and Players viewControllers.
            module.viewControler,
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
