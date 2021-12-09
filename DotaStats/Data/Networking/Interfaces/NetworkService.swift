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
    
    @discardableResult
    func processRequest<T: Decodable>(
        request: HTTPRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Cancellable? {
        do {
            let configuratedURLRequest = try configureRequest(request: request)

            let task = urlSession.dataTask(with: configuratedURLRequest) { data, response, _ in
                guard let response = response as? HTTPURLResponse, let unwrappedData = data else {
                    print("sssss")
                    completion(.failure(HTTPError.decodingFailed))
                    return
                }
                let handledResult = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    
                switch handledResult {
                case .success:
                    let jsonDecoder = JSONDecoder()
                    
                    guard let result = try? jsonDecoder.decode(T.self, from: unwrappedData) else {
                        completion(.failure(HTTPError.decodingFailed))
                        return
                    }
                        
                    completion(.success(result))
                case .failure:
                    completion(.failure(HTTPError.decodingFailed))
                }
            }
                
            task.resume()
            return task
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
    private func configureRequest(request: HTTPRequest) throws -> URLRequest {
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
