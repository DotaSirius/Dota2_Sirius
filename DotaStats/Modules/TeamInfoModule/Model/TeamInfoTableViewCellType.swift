enum TeamInfoTableViewCellType {
    case mainTeamInfo (MainTeamInfo)
    case teamButtonsInfo
//    case matchPlayerInfo (PlayerList)
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

        }
    }
}
