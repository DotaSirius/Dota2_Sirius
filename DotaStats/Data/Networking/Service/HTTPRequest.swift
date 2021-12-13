//
//  HTTPRequest.swift
//  DotaStats
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation

typealias HTTPRequestQueryItem = (key: String, value: String?)

struct HTTPRequest {
    let route: String
    let headers: [String: String]
    let body: Data?
    let queryItems: [HTTPRequestQueryItem]
    let httpMethod: HTTPMethod

    init(
        route: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        queryItems: [HTTPRequestQueryItem] = [],
        httpMethod: HTTPMethod = .get
    ) {
        self.route = route
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
        self.httpMethod = httpMethod
    }
}
