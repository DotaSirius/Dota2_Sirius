//
//  MatchDetailService.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import Foundation
import UIKit

protocol MatchDetailService: AnyObject {
	func requestMatchDetail(id: Int, closure: @escaping (Result<MatchDetail, HTTPError>) -> Void) -> Cancellable?
}

class MatchDetailImp: MatchDetailService {
	let networkClient: NetworkClient

	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}

	@discardableResult
	func requestMatchDetail(id: Int, closure: @escaping (Result<MatchDetail, HTTPError>) -> Void) -> Cancellable? {
		networkClient.processRequest(request: createRequest(id: id)) { result in
			closure(result)
		}
	}

	private func createRequest(id: Int) -> HTTPRequest {
		HTTPRequest(route: "https://api.opendota.com/api/matches/\(id)")
	}
}
