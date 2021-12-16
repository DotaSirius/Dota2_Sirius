import Foundation

protocol TeamInfoService: AnyObject {
    func requestTeamMainInfo(id: Int, completion: @escaping (Result<TeamResult, HTTPError>) -> Void) -> Cancellable?
}

final class TeamInfoImp: TeamInfoService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestTeamMainInfo(id: Int, completion: @escaping (Result<TeamResult, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(id: id),
            completion: completion
        )
    }

    private func createRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams/\(id)")
    }
}
