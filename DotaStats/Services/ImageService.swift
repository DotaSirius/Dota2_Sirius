//
//  ImageService.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import Foundation
import UIKit

protocol ImageService: AnyObject {
    func loadWithUrl(_ url: String, _ completion: @escaping (Result<UIImage, HTTPError>) -> Void)
}

class ImageServiceImp: ImageService {

    private let urlSession: URLSession = {
        let config = URLSessionConfiguration.default

        return URLSession(configuration: config)
    }()

    func loadWithUrl(_ url: String, _ completion: @escaping (Result<UIImage, HTTPError>) -> Void) {
        guard let requestUrl = URL(string: url) else {
                completion(.failure(HTTPError.missingURL))
            return
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
    }
}
