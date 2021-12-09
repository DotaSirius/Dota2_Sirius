//
//  HTTPNetworkResponse.swift
//  DotaStats
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation

struct HTTPNetworkResponse {
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> NetworkCommunicationResult<String> {
        guard let res = response else {
            return NetworkCommunicationResult.failure(HTTPError.UnwrappingError)
        }

        switch res.statusCode {
        case 200...299: return NetworkCommunicationResult.success(HTTPError.success.rawValue)
        case 401: return NetworkCommunicationResult.failure(HTTPError.authenticationError)
        case 400...499: return NetworkCommunicationResult.failure(HTTPError.badRequest)
        case 500...599: return NetworkCommunicationResult.failure(HTTPError.serverSideError)
        default: return NetworkCommunicationResult.failure(HTTPError.failed)
        }
    }
}
