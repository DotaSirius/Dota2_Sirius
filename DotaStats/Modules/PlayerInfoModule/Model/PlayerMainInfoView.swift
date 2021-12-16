import Foundation

struct PlayerMainInfoView {
    var name: String = ""
    var avatar: String? = nil
    var leaderboardRank: Int = 0
    
    init(name: String = "", avatar: String? = nil, leaderboardRank: Int = 0) {
        self.name = name
        self.avatar = avatar
        self.leaderboardRank = leaderboardRank
    }
}
