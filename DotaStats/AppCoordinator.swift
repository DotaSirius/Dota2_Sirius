import Foundation
import UIKit

final class AppCoordinator {
    let tabBarController: MainTabBarController = .init()

    init() {
        let teamsModule = teamsModuleBuilder()
        let matchesModule = matchesBuilder()
        let playerSearchModule = searchPlayerModuleBuilder()

        let viewControllers = [
            CustomNavigationController(rootViewController: teamsModule.viewController, title: "Teams"),
            CustomNavigationController(rootViewController: matchesModule.viewController, title: "Tournaments"),
            CustomNavigationController(rootViewController: playerSearchModule.viewController, title: "Search")
        ]

        let tabImageNames = [
            NSLocalizedString("players", comment: ""),
            NSLocalizedString("matches", comment: ""),
            NSLocalizedString("search", comment: "")
        ]

        tabBarController.setViewControllers(viewControllers, animated: false)
        tabBarController.tabImageNames = tabImageNames

        tabBarController.configureTabs()
        setupNavigationBarAppearance()
    }

    private func setupNavigationBarAppearance() {
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
            heroImagesService: GithubConstantsServiceImp(
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
            constantsService: GithubConstantsServiceImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            ),
            playerId: playerId
        )
    }

    private func teamInfoModuleBuilder(teamId: Int) -> TeamInfoModuleBuilder {
        TeamInfoModuleBuilder(
            converter: TeamInfoConverterImp(), output: self,
            teamInfoService: TeamInfoImp(
                networkClient: NetworkClientImp(
                    urlSession: URLSession(configuration: .default)
                )
            ), teamId: teamId
        )
    }

    private func presentPlayerInfo(on viewController: UIViewController?, playerId: Int) {
        let playerInfoModule = makePlayerInfoModuleBuilder(playerId: playerId)
        viewController?.navigationController?.pushViewController(playerInfoModule.viewController, animated: true)
    }

    private func presentTeamInfo(on viewController: UIViewController?, teamId: Int) {
        let teamInfoModule = teamInfoModuleBuilder(teamId: teamId)
        viewController?.present(teamInfoModule.viewController, animated: true)
    }
}
extension AppCoordinator: TeamsModuleOutput {
    func teamsModule(_ module: TeamsModuleInput, didSelectTeam teamId: Int) {
        presentTeamInfo(on: tabBarController, teamId: teamId)
    }
}

extension AppCoordinator: MatchesModuleOutput {
    func matchesModule(
        _ module: MatchesModuleInput,
        didSelectMatch matchId: Int,
        on viewController: UIViewController
    ) {
        let matchInfoModule = makeMatchInfoModuleBuilder()
        matchInfoModule.input.setMatchId(matchId)
        viewController.navigationController?.pushViewController(matchInfoModule.viewController, animated: true)
    }
}

extension AppCoordinator: SearchPlayerModuleOutput {
    func searchModule(_ module: SearchPlayerModuleInput, didSelectPlayer player: PlayerInfoFromSearch) {
        // TODO: show player profile info
    }
}

extension AppCoordinator: PlayerInfoModuleOutput {}

extension AppCoordinator: MatchInfoModuleOutput {
    func matchInfoModule(
        _ module: MatchInfoModulePresenter,
        didSelectPlayer playerId: Int,
        on viewController: UIViewController
    ) {
        presentPlayerInfo(on: viewController, playerId: playerId)
    }
}

extension AppCoordinator: TeamInfoModuleOutput {
    func teamInfoModule(_ module: TeamInfoModulePresenter, didSelectTeam teamId: Int) {

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
