import Foundation
import UIKit

protocol MatchInfoConverter: AnyObject {
    func mainMatchInfo(from rawMatchInfo: MatchDetail) -> MainMatchInfo
    func additionalMatchInfo(from rawMatchInfo: MatchDetail) -> AdditionalMatchInfo
    func playerInfo(from rawMatchInfo: MatchDetail, playerNumber: Int) -> PlayerList
    func direMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo
    func radiantMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo
    func wardsMapInfo(from rawMatchInfo: MatchDetail) -> [Int: [MatchEvent]]
}

class MatchInfoConverterImp {
    // MARK: - PlayerList converters

    private func convert(playerName: String?, playerProName: String?) -> String {
        guard
            let playerName = playerName
        else {
            return "Anonymous"
        }
        if let playerProName = playerProName {
            return playerProName
        } else {
            return playerName
        }
    }

    // TODO: - Приходит в виде Int. Ранги в доте называются "Legend", "Immortal" и тд.
    // Сделать правильную конвертацию из цифр в ранги

    private func convert(playerRankTier: Int?) -> String {
        guard
            let playerRankTier = playerRankTier
        else {
            return "-"
        }
        return "\(playerRankTier)"
    }

    private func convert(networth: Int?) -> String {
        guard
            let networth = networth
        else {
            return "-"
        }
        return "\(networth / 1000)k"
    }

    private func convert(stat: Int?) -> String {
        guard
            let stat = stat
        else {
            return "-"
        }
        return "\(stat)"
    }

    // MARK: - MainMatchInfo converters

    private func convert(isRadiantWin: Bool?) -> String {
        guard
            let isRadiantWin = isRadiantWin
        else {
            return "-"
        }
        return isRadiantWin ? "Radiant Victory" : "Dire Victory"
    }

    private func convert(duration: Int?) -> String {
        guard
            let duration = duration
        else {
            return "-"
        }
        let hr = duration / 3600
        let min = (duration % 3600) / 60
        let sec = duration % 60
        let hrStr = hr == 0 ? "" : "\(hr):"
        let minStr = min < 10 ? "0\(min):" : "\(min):"
        let secStr = sec < 10 ? "0\(sec)" : "\(sec)"
        return "\(hrStr)\(minStr)\(secStr)"
    }

    private func convert(score: Int?) -> String {
        guard
            let score = score
        else {
            return "-"
        }
        return "\(score)"
    }

    // How long ago match was ended. Not implemented yet,
    // because in future startTime will be converted from Int to Date in Networking
    private func convert(startTime: Date?, duration: Int?) -> String {
        return "0 HOURS AGO."
    }

    // MARK: - AdditionalMatchInfo converters

    // TODO: - Check correctness of cases. I got them from
    // https://github.com/SteamDatabase/GameTracking-Dota2/blob/master/game/dota/pak01_dir/scripts/regions.txt

    // swiftlint:disable cyclomatic_complexity
    private func convert(region: Int?) -> String {
        guard
            let region = region
        else {
            return "-"
        }
        var regionString = ""
        switch region {
        case 0:
            regionString = "unspecified"
        case 1:
            regionString = "US West"
        case 2:
            regionString = "US East"
        case 3:
            regionString = "Europe"
        case 5:
            regionString = "Singapore"
        case 6:
            regionString = "Dubai"
        case 7:
            regionString = "Australia"
        case 8:
            regionString = "Stockholm"
        case 9:
            regionString = "Austria"
        case 10:
            regionString = "Brazil"
        case 11:
            regionString = "South Africa"
        case 14:
            regionString = "Chile"
        case 15:
            regionString = "Peru"
        case 16:
            regionString = "India"
        case 19:
            regionString = "Japan"
        case 37:
            regionString = "Taiwan"
        default:
            regionString = "Other"
        }
        return regionString
    }

    // swiftlint:enable cyclomatic_complexity

    private func convert(skillBracket: Int?) -> String {
        guard
            let skillBracket = skillBracket
        else {
            return "-"
        }
        return "\(skillBracket)"
    }
}

extension MatchInfoConverterImp: MatchInfoConverter {
    func wardsMapInfo(from rawMatchInfo: MatchDetail) -> [Int : [MatchEvent]] {
        MatchDetailToEventsConverter.convert(rawMatchInfo)
    }

    func mainMatchInfo(from rawMatchInfo: MatchDetail) -> MainMatchInfo {
        let winnersLabelText = convert(isRadiantWin: rawMatchInfo.radiantWin)
        let gameTimeLabelText = convert(duration: rawMatchInfo.duration)
        let firstTeamScoreLabelText = convert(score: rawMatchInfo.radiantScore)
        let secondTeamScoreLabelText = convert(score: rawMatchInfo.direScore)
        let matchEndTimeLabelText = convert(startTime: rawMatchInfo.startTime, duration: rawMatchInfo.duration)
        return MainMatchInfo(
            winnersLabelText: winnersLabelText,
            gameTimeLabelText: gameTimeLabelText,
            firstTeamScoreLabelText: firstTeamScoreLabelText,
            secondTeamScoreLabelText: secondTeamScoreLabelText,
            matchEndTimeLabelText: matchEndTimeLabelText
        )
    }

    func additionalMatchInfo(from rawMatchInfo: MatchDetail) -> AdditionalMatchInfo {
        let matchIdLabelText = "\(rawMatchInfo.matchId)"
        let regionLabelText = convert(region: rawMatchInfo.region)
        let skillLabelText = convert(skillBracket: rawMatchInfo.skill)
        return AdditionalMatchInfo(
            matchIdLabelText: matchIdLabelText,
            regionLabelText: regionLabelText,
            skillLabelText: skillLabelText
        )
    }

    func playerInfo(from rawMatchInfo: MatchDetail, playerNumber: Int) -> PlayerList {
        var safeNumber: Int
        if playerNumber < rawMatchInfo.players.count {
            safeNumber = playerNumber
        } else {
            safeNumber = rawMatchInfo.players.count - 1
        }
        let player = rawMatchInfo.players[safeNumber]
        let playerNameLabelText = convert(playerName: player.personaname, playerProName: player.name)
        let playerRankText = convert(playerRankTier: player.rankTier)
        let playerKillsText = convert(stat: player.kills)
        let playerDeathsText = convert(stat: player.deaths)
        let playerAssitsText = convert(stat: player.assists)
        let playerGoldText = convert(networth: player.totalGold)
        return PlayerList(
            playerNameLabelText: playerNameLabelText,
            playerRankText: playerRankText,
            playerKillsText: playerKillsText,
            playerDeathsText: playerDeathsText,
            playerAssitsText: playerAssitsText,
            playerGoldText: playerGoldText,
            playerImage: UIImage(named: "morphling") ?? UIImage()
        )
    }

    func radiantMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo {
        let teamNameLabelText = "Radiant"
        guard
            let isRadiantWin = rawMatchInfo.radiantWin
        else {
            return TeamMatchInfo(teamNameLabelText: teamNameLabelText, teamWinLabel: "")
        }
        let teamWinLabel = isRadiantWin ? "Winner" : ""
        return TeamMatchInfo(
            teamNameLabelText: teamNameLabelText,
            teamWinLabel: teamWinLabel
        )
    }

    func direMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo {
        let teamNameLabelText = "Dire"
        guard
            let isRadiantWin = rawMatchInfo.radiantWin
        else {
            return TeamMatchInfo(teamNameLabelText: teamNameLabelText, teamWinLabel: "")
        }
        let teamWinLabel = isRadiantWin ? "" : "Winner"
        return TeamMatchInfo(
            teamNameLabelText: teamNameLabelText,
            teamWinLabel: teamWinLabel
        )
    }
}
