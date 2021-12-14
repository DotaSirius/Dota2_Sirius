//
//  PresentorMethodsDraft.swift
//  DotaStats
//
//  Created by Костина Вероника  on 12.12.2021.
//

import UIKit
func getCellData (indexpath: Int) -> MatchTableViewCellData {
    
    var winnerLoserArray = [String]()
    winnerLoserArray = ["Winner", ""]
    
    
    let numberPlayersInMatch = 5 //взять кол-во игроков из сети

    var cellType = MatchTableViewCellType.mainMatchInfo(MainMatchInfo(winnersLabelText: "", gameTimeLabelText: "", firstTeamScoreLabelText: "", secondTeamScoreLabelText: "", matchEndTimeLabelText: "")) //TODO: если ничего не пришло, проинициализировать
    
    switch indexpath {
    case 0: cellType = .mainMatchInfo(MainMatchInfo(winnersLabelText: "Radiant victory", gameTimeLabelText: "24:10", firstTeamScoreLabelText: "66", secondTeamScoreLabelText: "56", matchEndTimeLabelText:"ENDED 14 HOURS AGO"))
    case 1: cellType = .additionalMatchInfo(AdditionalMatchInfo(matchIdLabelText: "74753461439", regionLabelText: "Stockholm", skillLabelText: "Normal")) //если инфа из сети не придет, пусть придет какой-то прочерк
    case 2: cellType = .teamMatchInfo(TeamMatchInfo(teamNameLabelText: "Команда", teamWinLabel: winnerLoserArray[indexpath-2]))
    case 3: cellType = .matchPlayerHeaderInfo
    case 4...3+numberPlayersInMatch: cellType = .matchPlayerInfo(PlayerList(playerNameLabelText: "Bob", playerRankText: "Immortal", playerKillsText: "9", playerDeathsText: "25", playerAssitsText: "3", playerGoldText: "5,7k", playerImage: UIImage(named: "morphling") ?? UIImage(systemName: "circle")!)) //force unwrap??? поменять кружок в перезенторе нельзя ui?
    case 4+numberPlayersInMatch: cellType = .teamMatchInfo(TeamMatchInfo(teamNameLabelText: "Команда 1", teamWinLabel: winnerLoserArray[indexpath-4-numberPlayersInMatch]))
    case 5+numberPlayersInMatch...5+numberPlayersInMatch*2: cellType = .matchPlayerInfo(PlayerList(playerNameLabelText: "Bob", playerRankText: "Immortal", playerKillsText: "9", playerDeathsText: "25", playerAssitsText: "3", playerGoldText: "5,7k", playerImage: UIImage(named: "morphling") ?? UIImage(systemName: "circle")!)) //force unwrap??? поменять кружок в перезенторе нельзя ui?

        
    default:
        break
    }
    return MatchTableViewCellData(type: cellType)
}
