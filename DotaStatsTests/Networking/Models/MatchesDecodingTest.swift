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

        XCTAssertEqual(match.matchId, 6312319970)
        XCTAssertEqual(match.duration, 1892)
        XCTAssertEqual(match.startTime, Date(timeIntervalSince1970: 1639054764))
        XCTAssertEqual(match.radiantTeamId, 8449479)
        XCTAssertEqual(match.radiantName, "Team GL")
        XCTAssertEqual(match.direTeamId, 8497676)
        XCTAssertEqual(match.direName, "SKY")
        XCTAssertEqual(match.leagueName, "Ultras Dota Pro League 2")
        XCTAssertEqual(match.leagueid, 13690)
        XCTAssertEqual(match.seriesId, 624012)
        XCTAssertEqual(match.seriesType, 1)
        XCTAssertEqual(match.radiantScore, 49)
        XCTAssertEqual(match.direScore, 19)
        XCTAssertEqual(match.radiantWin, true)
    }
}
