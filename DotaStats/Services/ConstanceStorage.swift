import Foundation

final class ConstanceStorage {

    static let instance = ConstanceStorage()

    var regionsData: [String: String]?
    var heroImages: [String: HeroImage]?
    var gameModes: [String: GameMode]?

    private init() {}
}
