import Foundation

struct PlayerMainInfoViewState {
    var name: String
    var avatarUrl: String?
    var leaderboardRank: Int

    init(name: String = "", avatarUrl: String? = nil, leaderboardRank: Int = 0) {
        self.name = name
        self.avatarUrl = avatarUrl
        self.leaderboardRank = leaderboardRank
    }
}
