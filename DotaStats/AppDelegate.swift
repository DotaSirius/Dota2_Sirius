import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let networkServise = NetworkClientImp(urlSession: .init(configuration: .default))
        let teamInfo = TeamMatchesImp(networkClient: networkServise)
        teamInfo.requestTeamMatches(id: 15) { result in
            switch result {
            case .success(let data):
                print("все ок")
            case .failure(let error):
                print(error)
            }
        }
        
        let appCoordinator = AppCoordinator()
        window!.rootViewController = appCoordinator.tabBarController
        window!.makeKeyAndVisible()
        return true
    }
}
