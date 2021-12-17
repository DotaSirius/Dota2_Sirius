enum TeamInfoTableViewCellType {
    case mainTeamInfo (TeamMainInfo)
    case preferredDataViewModePicker
    case teamsInfoMatchesHeader
    case currentPlayersInfo(CurrentPlayersInfo)
    case currentHeroesInfo(CurrentHeroesInfo)
    case teamsInfoMatches(TeamMatchesInfo)
//    case matchPlayerHeaderInfo
}

extension TeamInfoTableViewCellType {
    var reuseIdentificator: String {
        switch self {
        case .mainTeamInfo:
            return MainTeamInfoTableViewCell.reuseIdentifier
        case .preferredDataViewModePicker:
            return TeamButtonsInfoTableViewCell.reuseIdentifier
        case .teamsInfoMatchesHeader :
            return TeamsInfoMatchesHeader.reuseIdentifier
        case .currentPlayersInfo:
            return CurrentPlayersCell.reuseIdentifier
        case .currentHeroesInfo:
            return CurrentPlayersCell.reuseIdentifier
        case .teamsInfoMatches :
                    return TeamsInfoMatches.reuseIdentifier
        }
    }
}
