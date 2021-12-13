//
//  MatchDetailService.swift
//  DotaStats
//

import Foundation

protocol MatchDetailService: AnyObject {
    func requestMatchDetail(id: Int, completion: @escaping (Result<MatchDetail, HTTPError>) -> Void) -> Cancellable?
}

final class MatchDetailImp: MatchDetailService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestMatchDetail(id: Int, completion: @escaping (Result<MatchDetail, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(request: createRequest(id: id),
                                     completion: completion)
    }

    private func createRequest(id: Int) -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/matches/\(id)")
    }
}
