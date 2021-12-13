//
//  CachedImageView.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import UIKit

class CachedImageView: UIView {

    private let imageLoader = ImageServiceImp()


    func loadWithUrl(_ url: String, completion: @escaping (Result<[Players], HTTPError>) -> Void) {

    }
}
