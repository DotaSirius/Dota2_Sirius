import Foundation

protocol TeamHeroesService: AnyObject {
    func requestTeamHeroes(id: Int, completion: @escaping (Result<[TeamHeroes], HTTPError>) -> Void) -> Cancellable?
}

final class TeamHeroesImp: TeamHeroesService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestTeamHeroes(id: Int, completion: @escaping (Result<[TeamHeroes], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(id: id),
            completion: completion
        )
    }

    private func createRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)/heroes")
    }
}
