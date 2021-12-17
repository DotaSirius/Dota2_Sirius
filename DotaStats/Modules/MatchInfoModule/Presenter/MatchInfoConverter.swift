import Foundation
import UIKit

protocol MatchInfoConverter: AnyObject {
    func mainMatchInfo(from rawMatchInfo: MatchDetail) -> MainMatchInfo
    func additionalMatchInfo(
        from rawMatchInfo: MatchDetail,
        regions: [String: String]
    ) -> AdditionalMatchInfo
    func playerInfo(
        from rawMatchInfo: MatchDetail,
        playerNumber: Int,
        ranks: [String: String],
        heroImages: [String: HeroImage]
    ) -> PlayerList
    func direMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo
    func radiantMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo
    func wardsMapInfo(from rawMatchInfo: MatchDetail) -> [Int: [MatchEvent]]
}

class MatchInfoConverterImp {
    // MARK: - PlayerList converters

    private func convert(heroImages: [String: HeroImage], heroId: Int?) -> String {
        guard
            let heroId = heroId,
            let heroUrl = heroImages[String(heroId)]?.img
        else {
            return "https://offers-api.agregatoreat.ru/api/file/649bf689-2165-46b1-8e5c-0ec89a54c05f"
        }
        return "https://api.opendota.com" + heroUrl
    }

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

    private func convert(playerRankTier: Int?, ranks: [String: String]) -> String {
        guard
            let playerRankTier = playerRankTier,
            let firstNumberString = String(playerRankTier).first,
            let secondNumberString = String(playerRankTier).last,
            let rankString = ranks[String(firstNumberString)]
        else {
            return "Unknown"
        }
        if rankString == "Immortal" {
            return rankString
        } else {
            return rankString + " \(secondNumberString)"
        }
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

    private func convert(startTime: Date?, duration: Int?) -> String {
        guard
            let duration = duration,
            let startTime = startTime?.addingTimeInterval(Double(duration))
        else {
            return "Ended Long Time Ago.".uppercased()
        }
        return "Ended \(Converter.convertDate(startTime))".uppercased()
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
    func wardsMapInfo(from rawMatchInfo: MatchDetail) -> [Int: [MatchEvent]] {
        MatchDetailToEventsConverter.convert(rawMatchInfo)
    }

    func mainMatchInfo(from rawMatchInfo: MatchDetail) -> MainMatchInfo {
        var winnersLabelText = convert(isRadiantWin: rawMatchInfo.radiantWin)
        let gameTimeLabelText = convert(duration: rawMatchInfo.duration)
        let firstTeamScoreLabelText = convert(score: rawMatchInfo.radiantScore)
        let secondTeamScoreLabelText = convert(score: rawMatchInfo.direScore)
        let matchEndTimeLabelText = convert(startTime: rawMatchInfo.startTime, duration: rawMatchInfo.duration)
        if let radiantName = rawMatchInfo.radiantTeam?.name,
           let direName = rawMatchInfo.direTeam?.name,
           let radiantWin = rawMatchInfo.radiantWin {
            winnersLabelText = radiantWin ? radiantName : direName
        }
        return MainMatchInfo(
            winnersLabelText: winnersLabelText,
            gameTimeLabelText: gameTimeLabelText,
            firstTeamScoreLabelText: firstTeamScoreLabelText,
            secondTeamScoreLabelText: secondTeamScoreLabelText,
            matchEndTimeLabelText: matchEndTimeLabelText,
            isRadiantWin: rawMatchInfo.radiantWin ?? true
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

    func playerInfo(
        from rawMatchInfo: MatchDetail,
        playerNumber: Int, ranks: [String: String],
        heroImages: [String: HeroImage]
    ) -> PlayerList {
        var safeNumber: Int
        if playerNumber < rawMatchInfo.players.count {
            safeNumber = playerNumber
        } else {
            safeNumber = rawMatchInfo.players.count - 1
        }
        let player = rawMatchInfo.players[safeNumber]
        let playerNameLabelText = convert(playerName: player.personaname, playerProName: player.name)
        let playerRankText = convert(playerRankTier: player.rankTier, ranks: ranks)
        let playerKillsText = convert(stat: player.kills)
        let playerDeathsText = convert(stat: player.deaths)
        let playerAssitsText = convert(stat: player.assists)
        let playerGoldText = convert(networth: player.totalGold)
        let playerImage = convert(heroImages: heroImages, heroId: player.heroId)
        print(playerImage)
        return PlayerList(
            playerId: player.accountId ?? 0,
            playerNameLabelText: playerNameLabelText,
            playerRankText: playerRankText,
            playerKillsText: playerKillsText,
            playerDeathsText: playerDeathsText,
            playerAssitsText: playerAssitsText,
            playerGoldText: playerGoldText,
            playerImage: playerImage
        )
    }

    func radiantMatchInfo(from rawMatchInfo: MatchDetail) -> TeamMatchInfo {
        let teamNameLabelText = rawMatchInfo.radiantTeam?.name ?? "Radiant"
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
        let teamNameLabelText = rawMatchInfo.direTeam?.name ?? "Dire"
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
