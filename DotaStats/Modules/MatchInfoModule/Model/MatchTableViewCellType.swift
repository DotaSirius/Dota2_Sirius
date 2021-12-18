enum MatchTableViewCellType {
    case mainMatchInfo (MainMatchInfo)
    case preferredDataViewModePicker (PickedDisplayingMode)
    case additionalMatchInfo (AdditionalMatchInfo)
    case matchPlayerInfo (PlayerList)
    case teamMatchInfo (TeamMatchInfo)
    case wardsMapInfo ([Int: [MatchEvent]])
    case matchPlayerHeaderInfo
}

extension MatchTableViewCellType {
    var reuseIdentificator: String {
        switch self {
        case .mainMatchInfo:
            return MainMatchInfoTableViewCell.reuseIdentifier
        case .preferredDataViewModePicker:
            return PreferredDataViewModePickerCell.reuseIdentifier
        case .additionalMatchInfo:
            return AdditionalMatchInfoTableViewCell.reuseIdentifier
        case .matchPlayerInfo:
            return MatchPlayerCell.reuseIdentifier
        case .teamMatchInfo:
            return TeamMatchInfoTableViewCell.reuseIdentifier
        case .matchPlayerHeaderInfo:
            return PlayersTableHeaderCell.reuseIdentifier
        case .wardsMapInfo:
            return WardsMapTableViewCell.reuseIdentifier
        }
    }
}
