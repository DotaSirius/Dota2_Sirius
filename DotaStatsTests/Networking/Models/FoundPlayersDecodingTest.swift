import XCTest
@testable import DotaStats

class FoundPlayerDecodingTest: XCTestCase {
    func testJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let path = bundle.url(forResource: "MockFoundPlayers", withExtension: "json") else {
            XCTFail("Missing file: MockFoundPlayers.json")
            return
        }

        let jsonData = try Data(contentsOf: path)

        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try jsonDecoder.decode([FoundPlayers].self,
                                                   from: jsonData)
                
        let firstPlayer = decodedData[0]
        
        XCTAssertEqual(firstPlayer.accountId, 1265754261)
        XCTAssertEqual(firstPlayer.personaname, "aelita.lu")
        XCTAssertEqual(firstPlayer.avatarfull, "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg")
        XCTAssertEqual(firstPlayer.similarity, 25.616425)
        
    }
}
