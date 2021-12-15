import UIKit

final class PlayerInfoFromSearch {
    var avatar: UIImage?
    let accountId: Int
    let avatarFull: String?
    let personaname: String?
    let lastMatchTime: Date?

    init(from search: SearchPlayerResult) {
        avatarFull = search.avatarfull
        accountId = search.accountId
        personaname = search.personaname
        lastMatchTime = search.lastMatchTime
    }
}
