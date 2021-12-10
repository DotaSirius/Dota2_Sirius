//
//  NetworkServiceSimpleText.swift
//  DotaStatsTests
//
//  Created by Igor Efimov on 09.12.2021.
//

@testable import DotaStats
import Foundation
import XCTest

class NetworkServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> [String]? {
        var receivedResult: [String]? = nil

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

                receivedResult = constants
            case .failure:
                break
            }
        }

        waitForExpectations(timeout: 10, handler: .none)

        return receivedResult
    }

    func testArrayContainsSomeData() throws {
        let response = receiveData()

        guard let response = response else {
            XCTAssert(response != nil)
            return
        }

        XCTAssertFalse(response.isEmpty)
    }

    func testEveryCellOfArrayContainsSomeData() throws {
        let response = receiveData()

        guard let response = response else {
            XCTAssert(response != nil)
            return
        }

        response.forEach { string in
            XCTAssertFalse(string.isEmpty)
        }
    }
    
    func testArrayContainsSomeConstants() throws {
        let response = receiveData()

        guard let response = response else {
            XCTAssert(response != nil)
            return
        }

        let arrayOfConstants = ["abilities", "region", "cluster", "countries"]

        arrayOfConstants.forEach { constant in
            XCTAssert(response.contains(constant))
        }
    }
}
