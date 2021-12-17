import Foundation
import UIKit

protocol MatchInfoConverter: AnyObject {
    func mainMatchInfo(from rawMatchInfo: MatchDetail) -> MainMatchInfo
    func additionalMatchInfo(from rawMatchInfo: MatchDetail, regions: [String: String]) -> AdditionalMatchInfo
    func playerInfo(from rawMatchInfo: MatchDetail, playerNumber: Int) -> PlayerList
    func direMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo
    func radiantMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo
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
            return "Unknown"
        }
        return "\(playerRankTier)"
    }

    private func convert(networth: Int?) -> String {
        guard
            let networth = networth
        else {
            return "0"
        }
        return "\(networth / 1000)k"
    }

    private func convert(stat: Int?) -> String {
        guard
            let stat = stat
        else {
            return "0"
        }
        return "\(stat)"
    }

    // MARK: - MainMatchInfo converters

    private func convert(isRadiantWin: Bool?) -> String {
        guard
            let isRadiantWin = isRadiantWin
        else {
            return "Winner is not spesified"
        }
        return isRadiantWin ? "Radiant Victory" : "Dire Victory"
    }

    private func convert(duration: Int?) -> String {
        guard
            let duration = duration
        else {
            return "00:00"
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

    private func convert(region: Int?, regions: [String: String]) -> String {
        guard
            let region = region,
            let regionString = regions[String(region)]
        else {
            return "Unspesified"
        }
        return regionString
    }

    private func convert(skillBracket: Int?) -> String {
        guard
            let skillBracket = skillBracket
        else {
            return "Tournament"
        }
        return "\(skillBracket)"
    }
}

extension MatchInfoConverterImp: MatchInfoConverter {
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

    func additionalMatchInfo(from rawMatchInfo: MatchDetail, regions: [String: String]) -> AdditionalMatchInfo {
        let matchIdLabelText = "\(rawMatchInfo.matchId)"
        let regionLabelText = convert(region: rawMatchInfo.region, regions: regions)
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
            playerId: player.accountId ?? 0,
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
