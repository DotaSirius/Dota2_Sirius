import Foundation

final class ConstanceStorage {

    static let instance = ConstanceStorage()

    var regionsData: [String: String]?

    private init() {}
}
