//
//  HTTPRequest.swift
//  DotaStats
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation

struct HTTPRequest {
    let route: String
    let headers: [String: String]
    let body: Data?
    let httpMethod: HTTPMethod

    init(
        route: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        httpMethod: HTTPMethod = .get
    ) {
        self.route = route
        self.headers = headers
        self.body = body
        self.httpMethod = httpMethod
    }
}
