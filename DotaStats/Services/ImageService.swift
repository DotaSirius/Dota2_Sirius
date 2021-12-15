import Foundation
import UIKit

protocol ImageService: AnyObject {
    func loadWithUrl(_ url: String, _ completion: @escaping (Result<UIImage, HTTPError>) -> Void) -> Cancellable?
}

final class ImageServiceImp: ImageService {
    private let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    static var shared: ImageServiceImp = .init()

    private init() {}

    @discardableResult
    func loadWithUrl(_ url: String, _ completion: @escaping (Result<UIImage, HTTPError>) -> Void) -> Cancellable? {
        guard let requestUrl = URL(string: url) else {
            completion(.failure(HTTPError.missingURL))
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