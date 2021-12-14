import Foundation

final class AppCoordinator {
    let tabBarController: MainTabBarController = MainTabBarController()

    init() {
        let playersModule = playersBuilder()
        tabBarController.setViewControllers([playersModule.viewControler], animated: false)
        tabBarController.setViewControllers(items: [NSLocalizedString("players", comment: "")])
    }
}

extension AppCoordinator {
    private func playersBuilder() -> PlayersModuleBuilder {
        PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp()
        )
    }
}

extension AppCoordinator: PlayersModuleOutput {
    func playersModule(_ module: PlayersModuleInput, didSelectPlayer playerId: Int) {
        //let playerInfoBuilder = playerInfoModuleBuilder(output: self, networkService: NetworkServiceImp(), playerId: playerId)
    }
}
