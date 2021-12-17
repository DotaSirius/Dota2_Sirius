import Foundation
import UIKit

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let teamsModule = teamsModuleBuilder()
        let matchesModule = matchesBuilder()
        let playerSearchModule = searchPlayerModuleBuilder()

        let viewControllers = [
            makeNavigationController(rootViewController: teamsModule.viewController, title: "Teams"),
            makeNavigationController(rootViewController: matchesModule.viewController, title: "Matches"),
            playerSearchModule.viewController
        ]

        let tabImageNames = [
            NSLocalizedString("players", comment: ""),
            NSLocalizedString("matches", comment: ""),
            NSLocalizedString("search", comment: "")
        ]

        tabBarController.setViewControllers(viewControllers, animated: false)
        tabBarController.tabImageNames = tabImageNames
        tabBarController.configureTabs()
        setupNavigationBarAppereance()
    }

    private func makeNavigationController(rootViewController: UIViewController,
                                          title: String) -> UINavigationController {
        rootViewController.title = title
        rootViewController.view?.backgroundColor = ColorPalette.mainBackground
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }

    private func setupNavigationBarAppereance() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.mainText]
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        UINavigationBar.appearance().backgroundColor = ColorPalette.mainBackground
        UINavigationBar.appearance().barTintColor = ColorPalette.alternativeBackground
    }
}

extension AppCoordinator {
    private func teamsModuleBuilder() -> TeamsModuleBuilder {
        let networkClient = NetworkClientImp(urlSession: .init(configuration: .default))
        let teamsService = TeamsServiceImp(networkClient: networkClient)
        return TeamsModuleBuilder(output: self, teamsService: teamsService)
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

    private func makeMatchInfoModuleBuilder() -> MatchInfoModuleBuilder {
        MatchInfoModuleBuilder(
            output: self,
            networkService: MatchDetailImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            ),
            regionsService: RegionsServiceImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            ),
            converter: MatchInfoConverterImp()
        )
    }

    private func makePlayerInfoModuleBuilder(playerId: Int) -> PlayerInfoModuleBuilder {
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

    private func presentPlayerInfo(on viewController: UIViewController?, playerId: Int) {
        let playerInfoModule = makePlayerInfoModuleBuilder(playerId: playerId)
        viewController?.present(playerInfoModule.viewController, animated: true)
    }
}

extension AppCoordinator: TeamsModuleOutput {
    func teamsModule(_ module: TeamsModuleInput, didSelectTeam teamId: Int) {
        //
    }
}

extension AppCoordinator: MatchesModuleOutput {
    func matchesModule(_ module: MatchesModuleInput, didSelectMatch matchId: Int) {
        let matchInfoModule = makeMatchInfoModuleBuilder()
        matchInfoModule.input.setMatchId(matchId)
        tabBarController.present(matchInfoModule.viewController, animated: true)
    }
}

extension AppCoordinator: SearchPlayerModuleOutput {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: PlayerInfoFromSearch) {
        // TODO: show player profile info
    }
}

extension AppCoordinator: PlayerInfoModuleOutput {}

extension AppCoordinator: MatchInfoModuleOutput {
    func matchInfoModule(_ module: MatchInfoModulePresenter, didSelectPlayer playerId: Int) {
        presentPlayerInfo(on: tabBarController.presentedViewController, playerId: playerId)
    }
}

final class StubImageNetworkService: ImageNetworkService {
    func loadImageFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.failure(HTTPError.dataTaskFailed))
        }
        return nil
    }
}
