@testable import DotaStats
import XCTest

class ProPlayersServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> [ProPlayer]? {
        var receivedResult: [ProPlayer]?
        
        let expectations = expectation(description: "\(#function)\(#line)")
        
        let urlSession = URLSession(configuration: .default)
        
        let networkClient = NetworkClientImp(urlSession: urlSession)
        
        let playersService = ProPlayerServiceImp(networkClient: networkClient)
        
        playersService.requestProPlayers { result in
            switch result {
            case .success(let proPlayers):
                expectations.fulfill()
                
                receivedResult = proPlayers
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
    
    func testResponseContainsArrayOfPlayers() throws {
        let response = receiveData()

        guard let response = response else {
            XCTFail("Missing response")
            return
        }

        XCTAssertFalse(response.isEmpty)
    }

    func testAnyPlayerContainsRequiredData() throws {
        let response = receiveData()

        guard let response = response else {
            XCTFail("Missing response")
            return
        }

        response.forEach { player in
            XCTAssert(player.accountId > 0)
            XCTAssert(player.isPro)
        }
    }
}
