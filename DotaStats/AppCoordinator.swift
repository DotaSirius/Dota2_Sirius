import Foundation

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let playersModule = playersBuilder()
        let matchInfoModule = matchInfoBuilder()
        
        let viewControllers = [
            playersModule.viewController,
            matchInfoModule.viewControler
        ]
        let items = [
            NSLocalizedString("players", comment: ""),
            NSLocalizedString("matches", comment: "")
        ]
        tabBarController.setViewControllers(viewControllers, animated: false)
        tabBarController.setViewControllers(items: items)
    }
}

extension AppCoordinator {
    private func playersBuilder() -> PlayersModuleBuilder {
        PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp()
        )
    }
    
    private func matchInfoBuilder() -> MatchInfoModuleBuilder {
        MatchInfoModuleBuilder(
            output: self,
            networkService: NetworkServiceImp()
        )
    }
}

extension AppCoordinator: PlayersModuleOutput {
    func playersModule(_ module: PlayersModuleInput, didSelectPlayer playerId: Int) {
        // let playerInfoBuilder =
        // playerInfoModuleBuilder(output: self, networkService: NetworkServiceImp(), playerId: playerId)
    }
}

extension AppCoordinator: MatchInfoModuleOutput {}
