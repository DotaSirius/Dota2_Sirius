//
//  CachedImageView.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import UIKit

class CachedImageView: UIView {

    private let skeleton: SkeletonView?

    private let imageLoader: 

    override init(frame: CGRect) {
        self.skeleton = SkeletonView(frame: frame)
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadWithUrl(_ url: URL, completion: @escaping (Result<[Players], HTTPError>) -> Void) {

    }
}
