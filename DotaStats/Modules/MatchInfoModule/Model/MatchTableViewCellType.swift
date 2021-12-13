enum MatchTableViewCellType {
    case mainMatchInfo (MainMatchInfo)
    case additionalMatchInfo (AdditionalMatchInfo)
    case matchPlayerInfo (PlayerList)
}

extension MatchTableViewCellType {
    var reuseIdentificator: String {
        switch self {
        case .mainMatchInfo:
            return MainMatchInfoTableViewCell.reuseIdentifier
        case .additionalMatchInfo:
            return AdditionalMatchInfoTableViewCell.reuseIdentifier
        case .matchPlayerInfo:
            return MatchPlayerCell.reuseIdentifier
        }
    }
}
