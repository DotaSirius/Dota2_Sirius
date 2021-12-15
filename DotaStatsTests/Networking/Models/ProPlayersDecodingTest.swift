@testable import DotaStats
import XCTest

final class ProPlayersDecodingTest: XCTestCase {
    func testJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))

        guard let path = bundle.url(forResource: "MockProPlayers", withExtension: "json") else {
            XCTFail("Missing file: MockProPlayers.json")
            return
        }

        let jsonData = try Data(contentsOf: path)

        let formatter = DateFormatter.ISO8601WithSecondsFormatter

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)

        let decodedData = try jsonDecoder.decode([ProPlayer].self,
                                                 from: jsonData)

        let firstPlayer = decodedData[0]

        XCTAssertEqual(firstPlayer.accountId, 88470)
        XCTAssertEqual(firstPlayer.steamid, "76561197960354198")
        // swiftlint:disable line_length
        XCTAssertEqual(firstPlayer.avatar, "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/b9/b92793127bfa6ceb1edbd2b7b25011b1dc6db89e.jpg")
        XCTAssertEqual(firstPlayer.avatarmedium, "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/b9/b92793127bfa6ceb1edbd2b7b25011b1dc6db89e_medium.jpg")
        XCTAssertEqual(firstPlayer.avatarfull, "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/b9/b92793127bfa6ceb1edbd2b7b25011b1dc6db89e_full.jpg")
        // swiftlint:enable line_length
        XCTAssertEqual(firstPlayer.profileurl, "https://steamcommunity.com/id/misterdurst69/")
        XCTAssertEqual(firstPlayer.personaname, "Tzy丶")
        XCTAssertEqual(firstPlayer.lastLogin, nil)
        XCTAssertEqual(firstPlayer.fullHistoryTime, formatter.date(from: "2021-12-01T13:15:34.109Z"))
        XCTAssertEqual(firstPlayer.cheese, 0)
        XCTAssertEqual(firstPlayer.fhUnavailable, false)
        XCTAssertEqual(firstPlayer.loccountrycode, "CN")
        XCTAssertEqual(firstPlayer.name, "Tzy丶")
        XCTAssertEqual(firstPlayer.countryCode, "cn")
        XCTAssertEqual(firstPlayer.fantasyRole, 1)
        XCTAssertEqual(firstPlayer.teamId, 8126892)
        XCTAssertEqual(firstPlayer.teamName, "Team Magma")
        XCTAssertEqual(firstPlayer.teamTag, "Magma")
        XCTAssertEqual(firstPlayer.isLocked, true)
        XCTAssertEqual(firstPlayer.isPro, true)
        XCTAssertEqual(firstPlayer.lockedUntil, nil)
    }
}
