import Foundation
import UIKit

protocol TeamInfoConverter: AnyObject {
    func teamMainInfo(from rawMainTeamInfo: TeamInfo) -> TeamMainInfo
}

protocol TeamGamesInfoConverter: AnyObject {
    func teamGamesInfo(from rawTeamGamesInfo: [TeamPlayers], playerId: Int) -> CurrentPlayersInfo
}

class TeamInfoConverterImp {

    private func convert(name: String?) -> String {
          guard
              let name = name
          else {
              return "No Name"
          }
              return name
      }

    private func convert(wins: Int?) -> String {
        guard
            let wins = wins
        else {
            return "-"
        }
        return "\(wins)"
    }

    private func convert(rating: Float?) -> String {
        guard
            let rating = rating
        else {
            return "-"
        }
        return "\(rating)"
    }

    private func convert(stat: Int?) -> String {
        guard
            let stat = stat
        else {
            return "-"
        }
        return "\(stat)"
    }
}

extension TeamInfoConverterImp: TeamInfoConverter {
    func teamMainInfo(from rawTeamMainInfo: TeamInfo) -> TeamMainInfo {
        let teamNameLabelText = convert(name: rawTeamMainInfo.name)
        let winsLabelText = convert(stat: rawTeamMainInfo.wins)
        let lossesLabelText = convert(stat: rawTeamMainInfo.losses)
        let ratingLabelText = convert(rating: rawTeamMainInfo.rating)

        return TeamMainInfo(
            teamNameLabelText: teamNameLabelText,
            winsLabelText: winsLabelText,
            lossesLabelText: lossesLabelText,
            ratingLabelText: ratingLabelText
        )
    }
}

extension TeamInfoConverterImp: TeamGamesInfoConverter {
    func teamGamesInfo(from rawTeamGamesInfo: [TeamPlayers], playerId: Int) -> CurrentPlayersInfo {
        let playerNameLabelText = convert(name: rawTeamGamesInfo[playerId].name)
        let gamesLabelText = convert(stat: rawTeamGamesInfo[playerId].gamesPlayed)
        let winrateLabelText = convert(stat: rawTeamGamesInfo[playerId].wins)

        return CurrentPlayersInfo(
            playerNameLabelText: playerNameLabelText,
            gamesLabelText: gamesLabelText,
            winrateLabelText: winrateLabelText
        )
    }
}
