//
//  MatchModel.swift
//  DotaStats
//
//  Created by Костина Вероника  on 10.12.2021.
//

import Foundation

struct MatchTableViewData {
    let TableContent: [MatchTableViewCellData]
}

struct MatchTableViewCellData {
    let reuseIdentifier: String
    let type: MatchTableViewCellType
}

enum MatchTableViewCellType {
    case mainMatchInfo (MainMatchInfo)
    case additionalMatchInfo (AdditionalMatchInfo)
    //case playerList (PlayerList)
}

struct MainMatchInfo {
    let winnersLabelText: String
    let gameTimeLabelText: String
    let firstTeamScoreLabelText: String
    let secondTeamScoreLabel: String
}

struct AdditionalMatchInfo {
    let matchIdLabelText: String
    let regionLabelText: String
    let skillLabelText: String
}

struct PlayerList {
    let Player: String //добавить поля в таблице
}
