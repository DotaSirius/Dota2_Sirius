import XCTest
@testable import DotaStats

class PlayerDecodingTest: XCTestCase {
    func testJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.url(forResource: "MockPlayer", withExtension: "json") else {
            XCTFail("Missing file: MockPlayer.json")
            return
        }

        let jsonData = try Data(contentsOf: path)

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try jsonDecoder.decode(Players.self,
                                                   from: jsonData)
                
        XCTAssertEqual(decodedData.trackedUntil, nil)
        XCTAssertEqual(decodedData.leaderboardRank, nil)
        XCTAssertEqual(decodedData.mmrEstimate.estimate, nil)
        XCTAssertEqual(decodedData.competitiveRank, nil)
        XCTAssertEqual(decodedData.soloCompetitiveRank, nil)
        XCTAssertEqual(decodedData.rankTier, nil)
    }
}
