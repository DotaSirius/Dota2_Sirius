//
//  ImageService.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import Foundation
import UIKit

protocol ImageService: AnyObject {
    func loadWithUrl(_ url: String, _ closure: @escaping (Result<UIImage, HTTPError>) -> Void)
}

class ImageServiceImp: ImageService {
    let queue = DispatchQueue(label: "image-loader", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem)

    func loadWithUrl(_ url: String, _ closure: @escaping (Result<UIImage, HTTPError>) -> Void) {
        queue.async {
            guard let requestUrl = URL(string: url) else {
                self.mainThreadReturn {
                    closure(.failure(HTTPError.missingURL))
                }
                return
            }
            do {
                let data = try Data(contentsOf: requestUrl)
                guard let image = UIImage(data: data) else {
                    self.mainThreadReturn {
                        closure(.failure(HTTPError.decodingFailed))
                    }
                    return
                }
                self.mainThreadReturn {
                    closure(.success(image))
                }

            } catch {
                self.mainThreadReturn {
                    closure(.failure(HTTPError.failed))
                }
            }
        }
    }

    func mainThreadReturn(_ closure: () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
