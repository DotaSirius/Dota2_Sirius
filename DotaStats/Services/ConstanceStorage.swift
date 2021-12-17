import Foundation

final class ConstanceStorage {

    static let instance = ConstanceStorage()

    var regionsData: [String: String]?
    var heroImages: [String: HeroImage]?
    var gameModes: [String: GameMode]?
    var ranks: [String: String] = [
                        "1": "Herald",
                        "2": "Guardian",
                        "3": "Crusader",
                        "4": "Archon",
                        "5": "Legend",
                        "6": "Ancient",
                        "7": "Divine",
                        "8": "Immortal"
                    ]

    private init() {}
}
