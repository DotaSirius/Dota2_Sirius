//
//  NetworkCommunicationResult.swift
//  DotaStats
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation

enum NetworkCommunicationResult<T> {
    case success(T)
    case failure(Error)
}
