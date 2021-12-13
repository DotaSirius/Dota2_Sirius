import UIKit

struct PlayerSearch {
    var avatar: UIImage?
    let accountId: Int
    let avatarFull: String?
    let personaname: String?
    let lastMatchTime: Date?

    init(from search: Search) {
        self.avatarFull = search.avatarfull
        self.accountId = search.accountId
        self.personaname = search.personaname
        self.lastMatchTime = search.lastMatchTime
    }
}
