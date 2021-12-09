//
//  NetworkingInterface.swift
//  DotaStats
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

struct NetworkService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func processRequest<T: Decodable>(
        request: HTTPRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable? {
        do {
            let configuratedURLRequest = try NetworkService.configureRequest(request: request)
                
            let task = urlSession.dataTask(with: configuratedURLRequest) { data, result, _ in
                if let response = result as? HTTPURLResponse, let unwrappedData = data {
                    let handledResult = HTTPNetworkResponse.handleNetworkResponse(for: response)
                        
                    switch handledResult {
                    case .success:
                        let jsonDecoder = JSONDecoder()
//                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                        jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
                        
                        guard let result = try? jsonDecoder.decode(T.self, from: unwrappedData) else {
                            fatalError("Failed to decode received data.")
                        }
                            
                        completion(.success(result))
                    case .failure:
                        completion(.failure(HTTPError.decodingFailed))
                    }
                }
            }
                
            task.resume()
            return task
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
    static func configureRequest(request: HTTPRequest) throws -> URLRequest {
        guard let url = URL(string: request.route) else { throw HTTPError.missingURL }
        
        var generatedRequest = URLRequest(url: url)
        
        generatedRequest.httpMethod = request.httpMethod.rawValue
        generatedRequest.httpBody = request.body
        
        if case request.headers = request.headers {
            for processingHeader in request.headers {
                generatedRequest.addValue(processingHeader.key, forHTTPHeaderField: processingHeader.value)
            }
        }
        
        return generatedRequest
    }
}

extension URLSessionDataTask: Cancellable {}
