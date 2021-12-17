import Foundation
import UIKit

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let teamsModule = teamsModuleBuilder()
        let playersModule = playersBuilder()
        let matchesModule = matchesBuilder()
        let playerSearchModule = searchPlayerModuleBuilder()
        let plotModule = plotGmpBuilder()
        
        let viewControllers = [
            playersModule.viewController,
            matchesModule.viewController,
            playerSearchModule.viewControler,
            plotModule.viewControler
        ]

        let tabImageNames = [
            NSLocalizedString("players", comment: ""),
            NSLocalizedString("matches", comment: ""),
            NSLocalizedString("players", comment: ""),
            NSLocalizedString("players", comment: "")
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
    
    private func plotGmpBuilder() -> PlotGmpModuleBuilder {
        PlotGmpModuleBuilder(
            output: self,
            plotService: MatchDetailImp(
                networkClient: NetworkClientImp(urlSession: URLSession(configuration: .default)))
        )
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
        tabBarController.present(matchInfoModule.viewControler, animated: true)
    }
}

extension AppCoordinator: SearchPlayerModuleOutput {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: PlayerInfoFromSearch) {
        // TODO: show player profile info
    }
}

extension AppCoordinator: PlotGmpModuleOutput {
}

final class StubImageNetworkService: ImageNetworkService {
    func loadImageFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.failure(HTTPError.dataTaskFailed))
        }
        return nil
    }
}
