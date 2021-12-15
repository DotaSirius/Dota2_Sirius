import Foundation

protocol MatchInfoConverter: AnyObject {
    func getMainMatchInfo() -> MainMatchInfo
    func getAdditionalMatchInfo() -> AdditionalMatchInfo
    func getPlayerInfo(number: Int) -> PlayerList
    func getDireMatchInfo() -> TeamMatchInfo
    func getRadiantMatchInfo() -> TeamMatchInfo
}

class MatchInfoConverterImp: MatchInfoConverter {
    private let networkService: NetworkService

    private var matchInfoRaw: MatchDetail

    init(networkService: NetworkService) {
        // TODO: - We get data from network, but this part of networkService is not implemented yet, so I did this..
        self.networkService = networkService
        // swiftlint:disable line_length
        matchInfoRaw = MatchDetail(matchId: 12345678, barracksStatusDire: nil, barracksStatusRadiant: nil, chat: nil, cluster: nil, direScore: 44, draftTimings: nil, duration: 1371, engine: nil, firstBloodTime: nil, gameMode: nil, humanPlayers: nil, leagueid: nil, lobbyType: nil, matchSeqNum: nil, negativeVotes: nil, positiveVotes: nil, radiantScore: 34, radiantWin: true, startTime: nil, towerStatusDire: nil, towerStatusRadiant: nil, version: nil, replaySalt: nil, seriesId: nil, seriesType: nil, skill: nil, players: [MatchDetail.Player(matchId: 1, playerSlot: 2, abilityUpgradesArr: nil, accountId: nil, assists: nil, backpack0: nil, backpack1: nil, backpack2: nil, buybackLog: nil, campsStacked: nil, connectionLog: nil, creepsStacked: nil, deaths: nil, denies: nil, dnT: nil, gold: nil, goldPerMin: nil, goldSpent: nil, goldT: nil, heroDamage: nil, heroHealing: nil, heroId: nil, item0: nil, item1: nil, item2: nil, item3: nil, item4: nil, item5: nil, kills: nil, killsLog: nil, lastHits: nil, leaverStatus: nil, level: nil, lhT: nil, obsPlaced: nil, partyId: nil, partySize: nil, pings: nil, purchaseLog: nil, runePickups: nil, runesLog: nil, senPlaced: nil, stuns: nil, times: nil, towerDamage: nil, xpPerMin: nil, xpT: nil, personaname: nil, name: nil, radiantWin: nil, startTime: nil, duration: nil, cluster: nil, lobbyType: nil, gameMode: nil, patch: nil, region: nil, isRadiant: nil, win: nil, lose: nil, totalGold: nil, totalXp: nil, killsPerMin: nil, kda: nil, abandons: nil, neutralKills: nil, towerKills: nil, courierKills: nil, laneKills: nil, heroKills: nil, observerKills: nil, sentryKills: nil, roshanKills: nil, necronomiconKills: nil, ancientKills: nil, buybackCount: nil, observerUses: nil, sentryUses: nil, laneEfficiency: nil, laneEfficiencyPct: nil, lane: nil, laneRole: nil, isRoaming: nil, actionsPerMin: nil, lifeStateDead: nil, rankTier: nil, cosmetics: nil)], patch: nil, region: nil, throw: nil, comeback: nil, loss: nil, win: nil, replayUrl: nil)
    }
    // swiftlint:enable line_length

    func getMainMatchInfo() -> MainMatchInfo {
        let winnersLabelText = convert(isRadiantWin: matchInfoRaw.radiantWin)
        let gameTimeLabelText = convert(duration: matchInfoRaw.duration)
        let firstTeamScoreLabelText = convert(score: matchInfoRaw.radiantScore)
        let secondTeamScoreLabelText = convert(score: matchInfoRaw.direScore)
        let matchEndTimeLabelText = convert(startTime: matchInfoRaw.startTime, duration: matchInfoRaw.duration)
        return MainMatchInfo(
            winnersLabelText: winnersLabelText,
            gameTimeLabelText: gameTimeLabelText,
            firstTeamScoreLabelText: firstTeamScoreLabelText,
            secondTeamScoreLabelText: secondTeamScoreLabelText,
            matchEndTimeLabelText: matchEndTimeLabelText)
    }

    func getAdditionalMatchInfo() -> AdditionalMatchInfo {
        let matchIdLabelText = "\(matchInfoRaw.matchId)"
        let regionLabelText = convert(region: matchInfoRaw.region)
        let skillLabelText = convert(skillBracket: matchInfoRaw.skill)
        return AdditionalMatchInfo(
            matchIdLabelText: matchIdLabelText,
            regionLabelText: regionLabelText,
            skillLabelText: skillLabelText
        )
    }
    func getPlayerInfo(number: Int) -> PlayerList {
        var safeNumber: Int
        if number < matchInfoRaw.players.count {
            safeNumber = number
        } else {
            safeNumber = matchInfoRaw.players.count - 1
        }
        let player = matchInfoRaw.players[safeNumber]
        let playerNameLabelText = convert(playerName: player.name)
        let playerRankText = convert(playerRankTier: player.rankTier)
        let playerKillsText = convert(stat: player.kills)
        let playerDeathsText = convert(stat: player.deaths)
        let playerAssitsText = convert(stat: player.assists)
        let playerGoldText = convert(stat: player.totalGold)
        return PlayerList(
            playerNameLabelText: playerNameLabelText,
            playerRankText: playerRankText,
            playerKillsText: playerKillsText,
            playerDeathsText: playerDeathsText,
            playerAssitsText: playerAssitsText,
            playerGoldText: playerGoldText
        )
    }

    func getRadiantMatchInfo() -> TeamMatchInfo {
        let teamNameLabelText = "Radiant"
        guard
            let isRadiantWin = matchInfoRaw.radiantWin
        else {
            return TeamMatchInfo(teamNameLabelText: teamNameLabelText, teamWinLabel: "")
        }
        let teamWinLabel = isRadiantWin ? "Winner" : ""
        return TeamMatchInfo(teamNameLabelText: teamNameLabelText, teamWinLabel: teamWinLabel)
    }

    func getDireMatchInfo() -> TeamMatchInfo {
        let teamNameLabelText = "Dire"
        guard
            let isRadiantWin = matchInfoRaw.radiantWin
        else {
            return TeamMatchInfo(teamNameLabelText: teamNameLabelText, teamWinLabel: "")
        }
        let teamWinLabel = isRadiantWin ? "" : "Winner"
        return TeamMatchInfo(teamNameLabelText: teamNameLabelText, teamWinLabel: teamWinLabel)
    }

    // MARK: - PlayerList converters

    func convert(playerName: String?) -> String {
        guard
            let playerName = playerName
        else {
            return "-"
        }
        return playerName
    }

    func convert(playerRankTier: Int?) -> String {
        guard
            let playerRankTier = playerRankTier
        else {
            return "-"
        }
        return "\(playerRankTier)"
    }

    func convert(stat: Int?) -> String {
        guard
            let stat = stat
        else {
            return "-"
        }
        return "\(stat)"
    }

    // MARK: - MainMatchInfo converters

    func convert(isRadiantWin: Bool?) -> String {
        guard
            let isRadiantWin = isRadiantWin
        else {
            return "-"
        }
        return isRadiantWin ? "Radiant Victory" : "Dire Victory"
    }

    func convert(duration: Int?) -> String {
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

    func convert(score: Int?) -> String {
        guard
            let score = score
        else {
            return "-"
        }
        return "\(score)"
    }

// How long ago match was ended. Not implemented yet, because in future startTime will be converted from Int to Date in Networking
    func convert(startTime: Date?, duration: Int?) -> String {
        return "0 HOURS AGO."
    }

    // MARK: - AdditionalMatchInfo converters

    func convert(region: Int?) -> String {
        guard
            let region = region
        else {
            return "-"
        }
        return "\(region)"
    }

    func convert(skillBracket: Int?) -> String {
        guard
            let skillBracket = skillBracket
        else {
            return "-"
        }
        return "\(skillBracket)"
    }
}
