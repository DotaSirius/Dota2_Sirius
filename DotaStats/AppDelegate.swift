import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else { return false }
        let appCoordinator = AppCoordinator()
        window.rootViewController = appCoordinator.tabBarController
        window.makeKeyAndVisible()
        return true
//
//
//        let network = NetworkClientImp(urlSession: .init(configuration: .default))
//        let teamServiceImp = TeamsServiceImp(networkClient: network)
//        teamServiceImp.requestTeams { result in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error)
//                break
//            }
//        }
//        let view = TeamsModuleViewController()
//        view.title = "Teams"
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.text]
//        UINavigationBar.appearance().backgroundColor = ColorPalette.mainBackground
//
//        let navigationController = UINavigationController(rootViewController: view)
//        navigationController.navigationBar.backgroundColor = ColorPalette.mainBackground
//        navigationController.navigationBar.barTintColor = ColorPalette.mainBackground
//
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//        return true
    }
}
