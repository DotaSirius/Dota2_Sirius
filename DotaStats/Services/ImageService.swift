//
//  ImageService.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import Foundation
import UIKit

protocol ImageService: AnyObject {
    func loadWithUrl(_ url: String, _ closure: @escaping (Result<UIImage, HTTPError>) -> Void) -> Cancellable?
}

class ImageServiceImp: ImageService {

    let queue = DispatchQueue(label: "image-loader", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem)

    func loadWithUrl(_ url: String, _ closure: @escaping (Result<UIImage, HTTPError>) -> Void) {
        queue.async {
            let requestUrl = URL(string: url)
            let data = Data(contentsOf: requestUrl)
        }
    }


}
