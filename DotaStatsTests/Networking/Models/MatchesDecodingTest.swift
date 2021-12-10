//
//  MatchesDecodingTest.swift
//  DotaStatsTests
//
//  Created by Igor Efimov on 10.12.2021.
//

import XCTest
@testable import DotaStats

class MatchesDecodingTest: XCTestCase {
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

        let decodedData = try jsonDecoder.decode(ProMatches.self,
                                                         from: jsonData)

        XCTAssertEqual(decodedData.matches[0].matchId, 6312319970)
        XCTAssertEqual(decodedData.matches[0].duration, 1892)
        XCTAssertEqual(decodedData.matches[0].startTime, Date(timeIntervalSince1970: 1639054764))
        XCTAssertEqual(decodedData.matches[0].radiantTeamId, 8449479)
        XCTAssertEqual(decodedData.matches[0].radiantName, "Team GL")
        XCTAssertEqual(decodedData.matches[0].direTeamId, 8497676)
        XCTAssertEqual(decodedData.matches[0].direName, "SKY")
        XCTAssertEqual(decodedData.matches[0].leagueName, "Ultras Dota Pro League 2")
        XCTAssertEqual(decodedData.matches[0].leagueid, 13690)
        XCTAssertEqual(decodedData.matches[0].seriesId, 624012)
        XCTAssertEqual(decodedData.matches[0].seriesType, 1)
        XCTAssertEqual(decodedData.matches[0].radiantScore, 49)
        XCTAssertEqual(decodedData.matches[0].direScore, 19)
        XCTAssertEqual(decodedData.matches[0].radiantWin, true)
    }
}
