//
//  MatchesServiceTest.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 11.12.2021.
//

import Foundation
import XCTest

class MatchesServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> ProMatches? {
        var receivedResult: ProMatches?
        
        let expectations = expectation(description: "\(#function)\(#line)")
        
        let urlSession = URLSession(configuration: .default)
        
        let networkClient = NetworkClientImp(urlSession: urlSession)
        
        let matchesService = MatchesServiceImp(networkClient: networkClient)
        
        matchesService.requestProMatches { (result: Result<ProMatches, HTTPError>) in
            switch result {
            case .success(let proMatches):
                expectations.fulfill()
                
                receivedResult = proMatches
            case .failure(_):
                XCTFail("Missing response")
                
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: .none)

        return receivedResult
    }
    
    func testArrayContainsSomeData() throws {
        let response = receiveData()

        guard response != nil else {
            XCTFail("Missing response")
            return
        }
    }
}
