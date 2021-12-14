import Foundation

public enum HTTPError: String, Error {
    case parametersNil = "Error: Parameters are nil"
    case headersNil = "Error: Headers are nil"
    case encodingFailed = "Error: Parameter encoding failed"
    case decodingFailed = "Error: Unable to decode the data"
    case missingURL = "Error: The URL is nil"
    case couldNotParse = "Error: Unable to parse the JSON response"
    case noData = "Error: The data from API is nil"
    case fragmentResponse = "Error  The API's response's body has fragments"
    case unwrappingError = "Error: Unable to unwrap the data"
    case dataTaskFailed = "Error: The data task object failed"
    case authenticationError = "Error: You must be authenticated"
    case badRequest = "Error: Bad request"
    case pageNotFound = "Error: Page/Route requested not found"
    case failed = "Error: Network request failed"
    case serverSideError = "Error: Server error"
    case missingURLComponents = "Error: The URL with components is nil"
}
