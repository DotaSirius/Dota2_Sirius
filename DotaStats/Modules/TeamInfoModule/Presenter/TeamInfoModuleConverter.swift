import Foundation
import UIKit

protocol TeamInfoConverter: AnyObject {
    func teamMainInfo(from rawMainTeamInfo: TeamInfo) -> TeamMainInfo
}

protocol TeamPlayersInfoConverter: AnyObject {
    func teamPlayersInfo(from rawTeamPlayersInfo: [TeamPlayers]) -> [CurrentPlayersInfo]
}

protocol TeamHeroesInfoConverter: AnyObject {
    func teamHeroesInfo(from rawTeamHeroesInfo: [TeamHeroes]) -> [CurrentHeroesInfo]
}

protocol TeamMatchesInfoConverter: AnyObject {
    func teamMatchesInfo(from rawMatchesTeamInfo: [TeamMatches]) -> [TeamMatchesInfo]
}

class TeamInfoConverterImp {
    var gamesArray = [Int]()
    
    private func convertDuration(seconds: Int?) -> String {
            guard
                let seconds = seconds
            else {
                return "Unknown"
            }
            var res = ""
            let hours = seconds / 3600
            let minutes = seconds / 60 - hours * 60
            let finalSec = seconds - hours * 60 - minutes * 60
            if hours <= 9, hours > 0 {
                res += "0\(hours):"
            } else if hours > 9 {
                res += "\(hours):"
            }
            if minutes <= 9, minutes > 0 {
                res += "0\(minutes):"
            } else if minutes > 9 {
                res += "\(minutes):"
            }
            if finalSec <= 9, finalSec > 0 {
                res += "0\(finalSec)"
            } else if minutes > 9 {
                res += "\(finalSec)"
            }
            return res
        }

    private func convert(name: String?) -> String {
          guard
              let name = name
          else {
              return "No Name"
          }
              return name
      }

    private func convert(rating: Float?) -> String {
        guard
            let rating = rating
        else {
            return "no rating"
        }
        return "\(rating)"
    }

    private func convert(stat: Int?) -> String {
        guard
            let stat = stat
        else {
            return "no data"
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

extension TeamInfoConverterImp: TeamPlayersInfoConverter {
    func teamPlayersInfo(from rawTeamPlayersInfo: [TeamPlayers]) -> [CurrentPlayersInfo] {
        let array: [CurrentPlayersInfo] = rawTeamPlayersInfo.compactMap({ rawInfo in
            guard
                rawInfo.isCurrentTeamMember == true,
                let name = rawInfo.name
            else {
                return nil
            }
            let gamesPlayed = rawInfo.gamesPlayed ?? 0
            let wins = rawInfo.wins ?? 0
            return .init(
                playerNameLabelText: name,
                gamesLabelText: String(gamesPlayed),
                winrateLabelText: String(wins)
            )
        })
        return array.sorted(by: {
            Int($0.gamesLabelText)! > Int($1.gamesLabelText)!
        })
    }
}

extension TeamInfoConverterImp: TeamHeroesInfoConverter {
    func teamHeroesInfo(from rawTeamHeroesInfo: [TeamHeroes]) -> [CurrentHeroesInfo] {
        var countOfElements = 0
        var array: [CurrentHeroesInfo] = rawTeamHeroesInfo.compactMap({ rawInfo in
            guard
                countOfElements <= 5,
                let name = rawInfo.localizedName
            else {
                return nil
            }
            let gamesPlayed = rawInfo.gamesPlayed ?? 0
            let wins = rawInfo.wins ?? 0
            countOfElements += 1
            return .init(
                heroesNameLabelText: name,
                heroesGamesLabelText: String(gamesPlayed),
                heroesWinrateLabelText: String(wins)
            )
        })
        array = Array(array.prefix(5))
        return array.sorted(by: {
            Int($0.heroesGamesLabelText)! > Int($1.heroesGamesLabelText)!
        })
    }
}

extension TeamInfoConverterImp: TeamMatchesInfoConverter {
    func teamMatchesInfo(from rawMatchesTeamInfo: [TeamMatches]) -> [TeamMatchesInfo] {

            let matches: [TeamMatchesInfo] = rawMatchesTeamInfo.compactMap { rawInfo in
                .init(
                    matches: rawInfo.leagueName ?? "No league",
                    leageName: rawInfo.leagueName ?? "Unknown",
                    duration: convertDuration(seconds: rawInfo.duration),
                    result: (rawInfo.radiantWin! && rawInfo.radiant!) || (!(rawInfo.radiantWin!) && !rawInfo.radiant!),
                    enemy: convert(name: rawInfo.opposingTeamName),
                    image: rawInfo.opposingTeamLogo ?? ""
                )
            }
            return Array(matches.prefix(50))
        }
}
