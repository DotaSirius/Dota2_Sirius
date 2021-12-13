//
//  NetworkClient.swift
//  DotaStats
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation

protocol NetworkClient {
	func processRequest<T: Decodable>(
		request: HTTPRequest,
		completion: @escaping (Result<T, HTTPError>) -> Void
	) -> Cancellable?
}

protocol Cancellable {
	func cancel()
}
