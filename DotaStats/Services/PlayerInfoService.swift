import Foundation

protocol PlayerInfoService: AnyObject {
    func requestPlayerMainInfo(id: Int, completion: @escaping (Result<PlayerMainInfo, HTTPError>) -> Void) -> Cancellable?
    func requestPlayerWLInfo(id: Int, completion: @escaping (Result<PlayerWL, HTTPError>) -> Void) -> Cancellable?
    func requestPlayerMatchesInfo(id: Int, completion: @escaping (Result<[PlayerMatch], HTTPError>) -> Void) -> Cancellable?
}

final class PlayerInfoImp: PlayerInfoService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestPlayerMainInfo(id: Int, completion: @escaping (Result<PlayerMainInfo, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createWLRequest(id: id),
            completion: completion
        )
    }
    
    @discardableResult
    func requestPlayerWLInfo(id: Int, completion: @escaping (Result<PlayerWL, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createPlayerRequest(id: id),
            completion: completion
        )
    }
    
    @discardableResult
    func requestPlayerMatchesInfo(id: Int, completion: @escaping (Result<[PlayerMatch], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createPlayerMatchesRequest(id: id),
            completion: completion
        )
    }

    private func createPlayerRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/players/\(id)")
    }
    
    private func createWLRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/players/\(id)/wl")
    }
    
    private func createPlayerMatchesRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/players/\(id)/recentMatches")
    }
}
