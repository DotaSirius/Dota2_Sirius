import XCTest

final class NetworkServiceReceivingDataByPassingQueriesTest: XCTestCase {
    private func receiveData() -> [Search]? {
        var receivedResult: [Search]?

        let expectations = expectation(description: "\(#function)\(#line)")

        let urlSession = URLSession(configuration: .default)

        let networkClient = NetworkClientImp(urlSession: urlSession)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"

        let searchPlayersRequest = HTTPRequest(
            route: "https://api.opendota.com/api/search",
            queryItems: [HTTPRequestQueryItem("q", "username")],
            dateDecodingStrategy: JSONDecoder.DateDecodingStrategy.formatted(formatter)
        )

        networkClient.processRequest(
            request: searchPlayersRequest
        ) { (result: Result<[Search], HTTPError>) in
            switch result {
            case .success(let search):
                expectations.fulfill()

                receivedResult = search
            case .failure:
                XCTFail("Missing response")
            }
        }

        waitForExpectations(timeout: 10, handler: .none)

        return receivedResult
    }

    func testArrayContainsSomeData() throws {
        guard let response = receiveData() else {
            XCTFail("Missing response")
            return
        }

        XCTAssertFalse(response.isEmpty)
    }

    func testEveryCellOfArrayContainsSomeData() throws {
        guard let response = receiveData() else {
            XCTFail("Missing response")
            return
        }

        response.forEach { searchItem in
            XCTAssert(searchItem.accountId > 0)
        }
    }
}
