import Foundation

protocol TeamInfoService: AnyObject {
    @discardableResult
    func requestTeamMainInfo(
        id: Int,
        completion: @escaping (Result<TeamInfo, HTTPError>) -> Void
    ) -> Cancellable?
    @discardableResult
    func requestTeamMatches(
        id: Int,
        completion: @escaping (Result<[TeamMatches], HTTPError>) -> Void
    ) -> Cancellable?
    @discardableResult
    func requestTeamHeroes(
        id: Int,
        completion: @escaping (Result<[TeamHeroes], HTTPError>) -> Void
    ) -> Cancellable?
    @discardableResult
    func requestTeamPlayers(
        id: Int,
        completion: @escaping (Result<[TeamPlayers], HTTPError>) -> Void
    ) -> Cancellable?
}

final class TeamInfoImp: TeamInfoService {
    func requestTeamMainInfo(id: Int, completion: @escaping (Result<TeamInfo, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createMainIfoRequest(id: id),
            completion: completion
        )
    }

    func requestTeamMatches(id: Int, completion: @escaping (Result<[TeamMatches], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createMatchesRequest(id: id),
            completion: completion
        )
    }

    func requestTeamHeroes(id: Int, completion: @escaping (Result<[TeamHeroes], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createHeroesRequest(id: id),
            completion: completion
        )
    }

    func requestTeamPlayers(id: Int, completion: @escaping (Result<[TeamPlayers], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createPlayersRequest(id: id),
            completion: completion
        )
    }

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    private func createMainIfoRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)")
    }

    private func createMatchesRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)/matches")
    }

    private func createHeroesRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)/heroes")
    }

    private func createPlayersRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)/players")
    }
}
