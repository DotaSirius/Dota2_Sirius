import Foundation

final class AppCoordinator {
    let tabBarController: MainTabBarController = MainTabBarController()

    init() {
        let playersBuilder = playersBuilder()
        let matchesBuilder = matchesBuilder()
        tabBarController.setViewControllers([playersBuilder.viewControler, matchesBuilder.viewControler], animated: false)
        tabBarController.setViewControllers(items: ["matches", "players"])
    }
}

extension AppCoordinator {
    func playersBuilder() -> PlayersModuleBuilder {
        PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp()
        )
    }
    
    func matchesBuilder() -> PlayersModuleBuilder { //MatchesModuleBuilder
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

extension AppCoordinator: SearchPlayerModuleOutput {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: Players) {
        //let playerInfoBuilder = playerInfoModuleBuilder(output: self, networkService: NetworkServiceImp(), playerId: playerId)
    }
}
