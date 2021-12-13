import Foundation

protocol MatchesModuleOutput {
    
}

protocol MatchesModuleInput {
    
}

protocol MatchInfoModuleOutput {
    
}

final class AppCoordinator {
    let tabBarController: MainTabBarController = MainTabBarController()

    func addControllers() {
        let playersBuilder = PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp())
        let matchesBuilder = PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp())
        tabBarController.setViewControllers([playersBuilder.viewControler, matchesBuilder.viewControler], animated: false)
        tabBarController.setViewControllers(items: ["matches", "players"])
    }
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
