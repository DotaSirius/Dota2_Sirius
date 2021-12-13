//
//  MatchesServiceTest.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 11.12.2021.
//

import Foundation
import XCTest

class MatchesServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> [Match]? {
        var receivedResult: [Match]?
        
        let expectations = expectation(description: "\(#function)\(#line)")
        
        let urlSession = URLSession(configuration: .default)
        
        let networkClient = NetworkClientImp(urlSession: urlSession)
        
        let matchesService = MatchesServiceImp(networkClient: networkClient)
        
        matchesService.requestProMatches { result in
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

        guard response != nil else {
            XCTFail("Missing response")
            return
        }
    }
    
    func testResponseContainsArrayOfMatches() throws {
        let response = receiveData()
        
        guard let response = response else {
            XCTFail("Missing response")
            return
        }

        XCTAssertFalse(response.isEmpty)
    }
    
    func testAnyMatchContainsRequiredData() throws {
        let response = receiveData()
        
        guard let response = response else {
            XCTFail("Missing response")
            return
        }
        
        response.forEach { match in
            XCTAssert(match.matchId > 0)
            XCTAssert(match.duration > 0)
        }
    }
}
