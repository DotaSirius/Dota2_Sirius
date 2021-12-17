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
    }
}
