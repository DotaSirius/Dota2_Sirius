import Foundation
import UIKit

protocol TeamInfoConverter: AnyObject {
    func teamMainInfo(from rawMainTeamInfo: TeamInfo) -> TeamMainInfo
}

class TeamInfoConverterImp {

    private func convert(teamName: String?) -> String {
          guard
              let teamName = teamName
          else {
              return "No Name"
          }
              return teamName
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
        let teamNameLabelText = convert(teamName: rawTeamMainInfo.name)
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
