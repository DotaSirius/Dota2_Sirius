import Foundation
import UIKit

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let teamsModule = teamsModuleBuilder()
        let matchesModule = matchesBuilder()
        let playerSearchModule = searchPlayerModuleBuilder()

        let viewControllers = [
            createNavigationController(for: teamsModule.viewController, with: "Команды"),
            matchesModule.viewController,
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

    private func createNavigationController(for viewController: UIViewController,
                                            with title: String) -> UINavigationController {
        viewController.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }

    private func setupNavigationBarAppereance() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorPalette.text]
        if #available(iOS 15, *) {

            UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
            UINavigationBar.appearance().barTintColor = ColorPalette.alternativeBackground
        } else {
            UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
            UINavigationBar.appearance().backgroundColor = ColorPalette.mainBackground
            UINavigationBar.appearance().barTintColor = ColorPalette.mainBackground
        }
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
}

extension AppCoordinator: TeamsModuleOutput {
    func teamsModule(_ module: TeamsModuleInput, didSelectTeam teamId: Int) {
        //
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

final class StubImageNetworkService: ImageNetworkService {
    func loadImageFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.failure(HTTPError.dataTaskFailed))
        }
        return nil
    }
}
