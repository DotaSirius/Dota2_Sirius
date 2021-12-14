import XCTest

final class PlayerSearchServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> [Search]? {
        var receivedResult: [Search]?

        let expectations = expectation(description: "\(#function)\(#line)")

        let urlSession = URLSession(configuration: .default)

        let networkClient = NetworkClientImp(urlSession: urlSession)

        let playerSearchService = PlayerSearchServiceImp(networkClient: networkClient)

        playerSearchService.playersByName("Test") { (result: Result<[Search], HTTPError>) in
            switch result {
            case .success(let searchResults):
                expectations.fulfill()

                receivedResult = searchResults
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

    func testAnyProfileContainsData() throws {
        let response = receiveData()

        guard let response = response else {
            XCTFail("Missing response")
            return
        }

        response.forEach { match in
            XCTAssert(match.accountId > 0)
        }
    }
}
