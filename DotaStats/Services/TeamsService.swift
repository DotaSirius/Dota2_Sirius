import Foundation

protocol TeamsService: AnyObject {
    func requestTeams(_ closure: @escaping (Result<[TeamResult], HTTPError>) -> Void) -> Cancellable?
}

class TeamsServiceImp: TeamsService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestTeams(_ closure: @escaping (Result<[TeamResult], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(),
            completion: closure
        )
    }

    private func createRequest() -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/teams")
    }
}
