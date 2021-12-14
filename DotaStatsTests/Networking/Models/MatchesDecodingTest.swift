@testable import DotaStats
import XCTest

final class MatchesDecodingTest: XCTestCase {
    func testJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))

        guard let path = bundle.url(forResource: "MockMatches", withExtension: "json") else {
            XCTFail("Missing file: MockMatches.json")
            return
        }

        let jsonData = try Data(contentsOf: path)

        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        let decodedData = try jsonDecoder.decode([Match].self,
                                                 from: jsonData)
        let match = decodedData[0]

        let firstMatch = decodedData[0]
        XCTAssertEqual(firstMatch.duration, 1892)
        XCTAssertEqual(firstMatch.startTime, Date(timeIntervalSince1970: 1639054764))
        XCTAssertEqual(firstMatch.radiantTeamId, 8449479)
        XCTAssertEqual(firstMatch.radiantName, "Team GL")
        XCTAssertEqual(firstMatch.direTeamId, 8497676)
        XCTAssertEqual(firstMatch.direName, "SKY")
        XCTAssertEqual(firstMatch.leagueName, "Ultras Dota Pro League 2")
        XCTAssertEqual(firstMatch.leagueid, 13690)
        XCTAssertEqual(firstMatch.seriesId, 624012)
        XCTAssertEqual(firstMatch.seriesType, 1)
        XCTAssertEqual(firstMatch.radiantScore, 49)
        XCTAssertEqual(firstMatch.direScore, 19)
        XCTAssertEqual(firstMatch.radiantWin, true)
    }
}
