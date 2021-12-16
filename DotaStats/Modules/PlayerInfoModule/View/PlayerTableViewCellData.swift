import Foundation

enum PlayerTableViewCellData {
    case playerMainInfo(PlayerMainInfoView)
    case playerWL(PlayerWLView)
    case playerMatch(PlayerMatchView)
    case recentMatchesTitle
    case recentMatchesHeader
}

extension PlayerTableViewCellData {
    var reuseIdentificator: String {
        switch self {
        case .playerMainInfo:
            return PlayerMainInfoCell.reuseIdentifier
        case .playerWL:
            return PlayerWLCell.reuseIdentifier
        case .playerMatch:
            return PlayerMatchCell.reuseIdentifier
        case .recentMatchesHeader:
            return RecentMatchesHeader.reuseIdentifier
        case .recentMatchesTitle:
            return RecentMatchesTitle.reuseIdentifier
        }
    }
}
