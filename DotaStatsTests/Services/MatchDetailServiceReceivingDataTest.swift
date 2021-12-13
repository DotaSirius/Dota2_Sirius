//
//  MatchDetailServiceReceivingDataTest.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 13.12.2021.
//

import Foundation
import XCTest

class MatchDetailServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> MatchDetail? {
        var receivedResult: MatchDetail?

        let expectations = expectation(description: "\(#function)\(#line)")

        let urlSession = URLSession(configuration: .default)

        let networkClient = NetworkClientImp(urlSession: urlSession)

        let matchDetailService = MatchDetailImp(networkClient: networkClient)

        matchDetailService.requestMatchDetail(id: 1) { result in
            switch result {
            case .success(let proMatches):
                expectations.fulfill()

                receivedResult = proMatches
            case .failure:
                XCTFail("Missing response")
            }
        }

        waitForExpectations(timeout: 10, handler: .none)

        return receivedResult
    }

    func testResponseContainsSomeData() throws {
        let response = receiveData()

        XCTAssertNotNil(response, "Missing response")
    }
}
