import XCTest

final class MatchDetailServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> MatchDetail? {
        var receivedResult: MatchDetail?

        let expectations = expectation(description: "\(#function)\(#line)")

        let urlSession = URLSession(configuration: .default)

        let networkClient = NetworkClientImp(urlSession: urlSession)

        let matchDetailService = MatchDetailImp(networkClient: networkClient)

        matchDetailService.requestMatchDetail(id: 1) { result in
            switch result {
            case .success(let matchDetail):
                expectations.fulfill()

                receivedResult = matchDetail
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
