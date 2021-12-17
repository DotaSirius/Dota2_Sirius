import Foundation

protocol GithubConstantsService: AnyObject {
    @discardableResult
    func requestImagesHero(completion: @escaping (Result<[String: HeroImage], HTTPError>) -> Void) -> Cancellable?
    @discardableResult
    func requestGameModes(completion: @escaping (Result<[String: GameMode], HTTPError>) -> Void) -> Cancellable?
}

final class GithubConstantsServiceImp: GithubConstantsService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func requestImagesHero(completion: @escaping (Result<[String: HeroImage], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(
                url: "https://raw.githubusercontent.com/odota/dotaconstants/master/build/heroes.json"
            ),
            completion: completion
        )
    }

    func requestGameModes(completion: @escaping (Result<[String : GameMode], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(
                url: "https://raw.githubusercontent.com/odota/dotaconstants/master/build/game_mode.json"
            ),
            completion: completion
        )
    }

    private func createRequest(url: String) -> HTTPRequest {
        HTTPRequest(route: url)
    }
}
