import Foundation

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let playersModule = playersBuilder()
        let matchesModule = matchesBuilder()
        tabBarController.setViewControllers([playersModule.viewController, matchesModule.viewController], animated: false)
        tabBarController.tabImageNames = [NSLocalizedString("players", comment: ""),NSLocalizedString("matches", comment: "")]
        tabBarController.configurateTabs()
    }
}

extension AppCoordinator {
    private func playersBuilder() -> PlayersModuleBuilder {
        PlayersModuleBuilder(
            output: self,
            networkService: NetworkServiceImp()
        )
    }
    
    private func matchesBuilder() -> MatchesModuleBuilder {
        MatchesModuleBuilder(
            output: self,
            matchesService: MatchesServiceImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            )
        )
    }
}

extension AppCoordinator: PlayersModuleOutput {
    func playersModule(_ module: PlayersModuleInput, didSelectPlayer playerId: Int) {
        // let playerInfoBuilder =
        // playerInfoModuleBuilder(output: self, networkService: NetworkServiceImp(), playerId: playerId)
    }
}

extension AppCoordinator: MatchesModuleOutput {
    func matchesModule(_ module: MatchesModuleInput, didSelectMatch matchId: Int) {
        // todo
    }
}
