import XCTest
@testable import DotaStats

final class HeroesServiceReceivingDataTest: XCTestCase {
    private func receiveData() -> [Hero]? {
        var receivedResult: [Hero]?

        let expectations = expectation(description: "\(#function)\(#line)")

        let urlSession = URLSession(configuration: .default)

        let networkClient = NetworkClientImp(urlSession: urlSession)

        let heroService = HeroesServiceImp(networkClient: networkClient)

        heroService.requestHeroes { result in
            switch result {
            case .success(let heroes):
                expectations.fulfill()

                receivedResult = heroes
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
