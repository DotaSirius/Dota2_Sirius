import UIKit

final class PlayerInfoFromSearch {
    var avatar: UIImage?
    let accountId: Int
    let avatarFull: String?
    let personaname: String?
    let lastMatchTime: Date?

    init(from search: SearchPlayerResult) {
        self.avatarFull = search.avatarfull
        self.accountId = search.accountId
        self.personaname = search.personaname
        self.lastMatchTime = search.lastMatchTime
    }
}
