import Foundation

protocol MatchesModuleOutput {
    
}

protocol MatchesModuleInput {
    
}

protocol MatchInfoModuleOutput {
    
}

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
    
    func matchesBuilder() -> PlayersModuleBuilder {
        PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp()
        )
    }
    
    //func playerInfoModuleBuilder() -> PlayersInfoModule { }
    //func matchInfoModuleBuilder() -> MatchInfoModule { }
    //func searchPlayerModuleBuilder() -> SearchPlayerModuleModule { }
}

extension AppCoordinator: MatchesModuleOutput {
    func matchesModule(_ module: MatchesModuleInput, didSelectMatch matchId: Int) {
        // todo
    }
}

extension AppCoordinator: PlayersModuleOutput {
    func playersModule(_ module: PlayersModuleInput, didSelectPlayer playerId: Int) {
        // todo
    }
}

extension AppCoordinator: SearchPlayerModuleOutput {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: Players) {
        // todo
    }
}
