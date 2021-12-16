import Foundation
import UIKit

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let playersModule = playersBuilder()
        let matchesModule = matchesBuilder()
        let playerSearchModule = searchPlayerModuleBuilder()
        // don't forget to replace
        let playerInfoModule = playerInfoModuleBuilder(playerId: 153125655)

        let viewControllers = [
            playersModule.viewController,
            matchesModule.viewController,
            playerSearchModule.viewController,
            playerInfoModule.viewController
        ]

        let tabImageNames = [
            NSLocalizedString("players", comment: ""),
            NSLocalizedString("matches", comment: ""),
            NSLocalizedString("search", comment: ""),
            NSLocalizedString("matches", comment: "")
        ]

        tabBarController.setViewControllers(viewControllers, animated: false)
        tabBarController.tabImageNames = tabImageNames
        tabBarController.configureTabs()
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

    private func searchPlayerModuleBuilder() -> SearchPlayerModuleBuilder {
        SearchPlayerModuleBuilder(
            output: self,
            playerSearchService: PlayerSearchServiceImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            ),
            // TODO: replace with correct image service
            imageNetworkService: StubImageNetworkService()
        )
    }

    private func playerInfoModuleBuilder(playerId: Int) -> PlayerInfoModuleBuilder {
        PlayerInfoModuleBuilder(
            output: self,
            playerInfoService: PlayerInfoServiceImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            ),
            playerId: playerId
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

extension AppCoordinator: SearchPlayerModuleOutput {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: PlayerInfoFromSearch) {
        // TODO: show player profile info
    }
}

extension AppCoordinator: PlayerInfoModuleOutput {
}

final class StubImageNetworkService: ImageNetworkService {
    func loadImageFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.failure(HTTPError.dataTaskFailed))
        }
        return nil
    }
}
