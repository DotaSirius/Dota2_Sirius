import Foundation

protocol TeamMatchesService: AnyObject {
    func requestTeamMatches(id: Int, completion: @escaping (Result<[TeamMatches], HTTPError>) -> Void) -> Cancellable?
}

final class TeamMatchesImp: TeamMatchesService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestTeamMatches(id: Int, completion: @escaping (Result<[TeamMatches], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(id: id),
            completion: completion
        )
    }

    private func createRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)/matches")
    }
}
