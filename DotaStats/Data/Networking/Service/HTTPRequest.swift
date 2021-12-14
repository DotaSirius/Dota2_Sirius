import Foundation

typealias HTTPRequestQueryItem = (key: String, value: String?)

struct HTTPRequest {
    let route: String
    let headers: [String: String]
    let body: Data?
    let queryItems: [HTTPRequestQueryItem]
    let httpMethod: HTTPMethod

    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy

    init(
        route: String,
        headers: [String: String] = [:],
        body: Data? = nil,
        queryItems: [HTTPRequestQueryItem] = [],
        httpMethod: HTTPMethod = .get,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970
    ) {
        self.route = route
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
        self.httpMethod = httpMethod
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
