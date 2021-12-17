enum TeamInfoTableViewCellType {
    case mainTeamInfo (TeamMainInfo)
    case teamButtonsInfo
    case teamsInfoMatchesHeader
    case currentPlayersInfo(CurrentPlayersInfo)
//    case teamMatchInfo (TeamMatchInfo)
//    case matchPlayerHeaderInfo
}

extension TeamInfoTableViewCellType {
    var reuseIdentificator: String {
        switch self {
        case .mainTeamInfo:
            return MainTeamInfoTableViewCell.reuseIdentifier
        case .teamButtonsInfo:
            return TeamButtonsInfoTableViewCell.reuseIdentifier
        case .teamsInfoMatchesHeader :
            return TeamsInfoMatchesHeader.reuseIdentifier
        case .currentPlayersInfo:
            return CurrentPlayersCell.reuseIdentifier
        }
    }
}
