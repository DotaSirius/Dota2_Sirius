import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = CostilViewController()
        vc.view.backgroundColor = UIColor.white
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
        
        
        return true
    }
}
