import Foundation
import UIKit

protocol ImageService: AnyObject {
    func fetchImage(with url: String, completion: @escaping (Result<UIImage, HTTPError>) -> Void) -> Cancellable?
}

final class ImageServiceImp: ImageService {
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .init(memoryCapacity: 1024 * 1024 * 100,
                                       diskCapacity: 1024 * 1024 * 100)
        let session = URLSession(configuration: configuration)
        return session
    }()

    static var shared: ImageServiceImp = .init()
    
    private init() {}

    @discardableResult
    func fetchImage(with url: String, completion: @escaping (Result<UIImage, HTTPError>) -> Void) -> Cancellable? {
        guard let requestUrl = URL(string: url) else {
            if let image = UIImage(named: url) {
                completion(.success(image))
            } else {
                completion(.failure(HTTPError.missingURL))
            }
            return nil
        }

        let task = urlSession.dataTask(with: requestUrl) { data, _, _ in
            guard let responseData = data, let image = UIImage(data: responseData) else {
                DispatchQueue.main.async {
                    completion(.failure(HTTPError.noData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
        return task
    }
}
