//
//  MatchesService.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 11.12.2021.
//

import Foundation

protocol MatchesService {
	func requestProMatches(_ closure: @escaping (Result<ProMatches, HTTPError>) -> Void) -> Cancellable?
}

struct MatchesServiceImp: MatchesService {

	private let networkClient: NetworkClient

	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}

	func requestProMatches(_ closure: @escaping (Result<ProMatches, HTTPError>) -> Void) -> Cancellable? {
		networkClient.processRequest(request: createRequest()) { result in
			closure(result)
		}
	}

	private func createRequest() -> HTTPRequest {
		 HTTPRequest(route: "https://api.opendota.com/api/proMatches")
	}

}
