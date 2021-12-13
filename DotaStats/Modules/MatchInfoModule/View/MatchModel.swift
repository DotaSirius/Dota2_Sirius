//
//  MatchModel.swift
//  DotaStats
//
//  Created by Костина Вероника  on 10.12.2021.
//

import Foundation
import UIKit

struct MatchTableViewCellData {
    var type: MatchTableViewCellType
}

enum MatchTableViewCellType {
    case mainMatchInfo (MainMatchInfo)
    case additionalMatchInfo (AdditionalMatchInfo)
    case matchPlayerInfo (PlayerList)
    case teamMatchInfo (TeamMatchInfo)
    case matchPlayerHeaderInfo
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
        case .teamMatchInfo:
            return TeamMatchInfoTableViewCell.reuseIdentifier
        case .matchPlayerHeaderInfo:
            return PlayersTableHeaderCell.reuseIdentifier
        }
    }
}

struct MainMatchInfo {
    let winnersLabelText: String
    let gameTimeLabelText: String
    let firstTeamScoreLabelText: String
    let secondTeamScoreLabelText: String
    let matchEndTimeLabelText: String
}

struct AdditionalMatchInfo {
    let matchIdLabelText: String
    let regionLabelText: String
    let skillLabelText: String
}

struct PlayerList {
    let playerNameLabelText: String
    let playerRankText: String
    let playerKillsText: String
    let playerDeathsText: String
    let playerAssitsText: String
    let playerGoldText: String
    let playerImage: UIImage
}

struct TeamMatchInfo {
    let teamNameLabelText: String
    let teamWinLabel: String
}
