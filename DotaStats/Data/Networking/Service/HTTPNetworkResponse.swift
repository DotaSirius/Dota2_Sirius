import Foundation

struct HTTPNetworkResponse {
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<Void, Error> {
        guard let res = response else {
            return .failure(HTTPError.unwrappingError)
        }

        switch res.statusCode {
        case 200...299: return .success(())
        case 401: return .failure(HTTPError.authenticationError)
        case 400...499: return .failure(HTTPError.badRequest)
        case 500...599: return .failure(HTTPError.serverSideError)
        default: return .failure(HTTPError.failed)
        }
    }
}
