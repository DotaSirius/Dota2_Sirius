//
//  PresentorMethodsDraft.swift
//  DotaStats
//
//  Created by Костина Вероника  on 12.12.2021.
//

import UIKit
func getCellData (indexpath: Int) -> MatchTableViewCellData {
    
    let numberPlayersInMatch = 5 //взять кол-во игроков из сети

    var cellType = MatchTableViewCellType.mainMatchInfo(MainMatchInfo(winnersLabelText: "", gameTimeLabelText: "", firstTeamScoreLabelText: "", secondTeamScoreLabelText: "", matchEndTimeLabelText: "")) //TODO: если ничего не пришло, проинициализировать
    
    switch indexpath {
    case 0: cellType = .mainMatchInfo(MainMatchInfo(winnersLabelText: "Radiant Victory", gameTimeLabelText: "24:10", firstTeamScoreLabelText: "29", secondTeamScoreLabelText: "5", matchEndTimeLabelText:"ENDED 14 HOURS AGO"))
    case 1: cellType = .additionalMatchInfo(AdditionalMatchInfo(matchIdLabelText: "74753461439", regionLabelText: "Stockholm", skillLabelText: "-")) //если инфа из сети не придет, пусть придет какой-то прочерк
    //case 2: добавить
    case 3...3+numberPlayersInMatch: cellType = .matchPlayerInfo(PlayerList(playerNameLabelText: "Bob", playerRankText: "Immortal", playerKillsText: "9", playerDeathsText: "25", playerAssitsText: "3", playerGoldText: "5,7k", playerImage: UIImage(named: "morphling") ?? UIImage(systemName: "circle")!)) //force unwrap??? поменять кружок в перезенторе нельзя ui?
    default:
        break
    }
    return MatchTableViewCellData(type: cellType)
}
