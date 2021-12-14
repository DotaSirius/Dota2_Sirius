import Foundation

protocol PlayerInfoService: AnyObject {
    func requestPlayerInfo(id: Int, completion: @escaping (Result<PlayerMainInfo, HTTPError>) -> Void) -> Cancellable?
}

final class PlayerInfoImp: PlayerInfoService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestPlayerInfo(id: Int, completion: @escaping (Result<PlayerMainInfo, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(id: id),
            completion: completion
        )
    }

    private func createRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/matches/\(id)")
    }
}
