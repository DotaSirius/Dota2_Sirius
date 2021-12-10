//
//  NetworkServiceSimpleText.swift
//  DotaStatsTests
//
//  Created by Igor Efimov on 09.12.2021.
//

@testable import DotaStats
import Foundation
import XCTest

class NetworkServiceSimpleTest: XCTestCase {
    func test() throws {
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
                    
                self.testArrayContainsSomeData(array: constants)
                
                self.testArrayContainsSomeSonstants(array: constants)
                
                self.testEveryCellOfArrayContainsSomeData(array: constants)
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: .none)
    }
    
    func testArrayContainsSomeData(array: [String]) {
        XCTAssertFalse(array.isEmpty)
    }
    
    private func testEveryCellOfArrayContainsSomeData(array: [String]) {
        array.forEach { string in
            XCTAssertFalse(string.isEmpty)
        }
    }
    
    private func testArrayContainsSomeSonstants(array: [String]) {
        let arrayOfConstants = ["abilities", "region", "cluster", "countries"]
        
        arrayOfConstants.forEach { constant in
            XCTAssert(array.contains(constant))
        }
    }
}
