//
//  NetworkServiceSimpleText.swift
//  DotaStatsTests
//
//  Created by Igor Efimov on 09.12.2021.
//

import Foundation
import XCTest
@testable import DotaStats

class NetworkServiceSimpleTest: XCTestCase {

    func testExample() throws {
        let expectations = expectation(description: "\(#function)\(#line)")
        
        let urlSession = URLSession(configuration: .default)
        
        let networkService = NetworkService(urlSession: urlSession)
        
        let constantsRequest = HTTPRequest(route: "https://api.opendota.com/api/constants")
        
        networkService.processRequest(
            request: constantsRequest
        ) { (result: Result<[String], Error>) in
            switch result {
            case .success(let constants):
                expectations.fulfill()
                print(constants)
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: .none)
    }
}
