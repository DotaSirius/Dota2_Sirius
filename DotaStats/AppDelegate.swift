import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = MainTabBarController()
        window!.rootViewController = root
        window!.makeKeyAndVisible()
        application.statusBarStyle = .lightContent
        return true
    }
}
