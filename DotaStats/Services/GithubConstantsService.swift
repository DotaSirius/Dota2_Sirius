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
            )
        ) { (result: Result<[String: HeroImage], HTTPError>) in
                switch result {
                case .success(let heroImages):
                    ConstanceStorage.instance.heroImages = heroImages
                case .failure:
                    break
                }
                completion(result)
            }
    }

    func requestGameModes(completion: @escaping (Result<[String : GameMode], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(
                url: "https://raw.githubusercontent.com/odota/dotaconstants/master/build/game_mode.json"
            )
        ) { (result: Result<[String: GameMode], HTTPError>) in
            switch result {
            case .success(let gameModes):
                ConstanceStorage.instance.gameModes = gameModes
            case .failure:
                break
            }
            completion(result)
        }
    }

    private func createRequest(url: String) -> HTTPRequest {
        HTTPRequest(route: url)
    }
}
