import Foundation

struct MatchDetail: Decodable {
    let matchId: Int
    let barracksStatusDire: Int?
    let barracksStatusRadiant: Int?
    let chat: [Chat]?
    let cluster: Int?
    let direScore: Int?
    let draftTimings: [DraftTiming]?
    let duration: Int?
    let engine: Int?
    let firstBloodTime: Date?
    let gameMode: Int?
    let humanPlayers: Int?
    let leagueid: Int?
    let lobbyType: Int?
    let matchSeqNum: Int?
    let negativeVotes: Int?
    let positiveVotes: Int?
    let radiantScore: Int?
    let radiantWin: Bool?
    let startTime: Date?
    let towerStatusDire: Int?
    let towerStatusRadiant: Int?
    let version: Int?
    let replaySalt: Int?
    let seriesId: Int?
    let seriesType: Int?
    let skill: Int?
    let players: [Player]
    let patch: Int?
    let region: Int?
    let `throw`: Int?
    let comeback: Int?
    let loss: Int?
    let win: Int?
    let replayUrl: String?

//    let cosmetics
//    let objectives
//    let picks_bans
//    let radiant_gold_adv
//    let radiant_xp_adv
//    let teamfights
//    let radiant_team
//    let dire_team
//    let league
//    let all_word_counts
//    let my_word_counts

    struct Chat: Decodable, Equatable {
        let time: Date?
        let unit: String?
        let key: String?
        let slot: Int?
        let playerSlot: Int?
    }

    struct DraftTiming: Decodable, Equatable {
        let order: Int
        let pick: Bool
        let activeTeam: Int
        let heroId: Int
        let playerSlot: Int?
        let extraTime: Int
        let totalTimeTaken: Int
    }

    struct Player: Decodable {
        let matchId: Int
        let playerSlot: Int?
        let abilityUpgradesArr: [Int]?
        let accountId: Int?
        let assists: Int?
        let backpack0: Int?
        let backpack1: Int?
        let backpack2: Int?
        let buybackLog: [BuybackLog]?
        let campsStacked: Int?
        let connectionLog: [ConnectionLog]?
        let creepsStacked: Int?
        let deaths: Int?
        let denies: Int?
        let dnT: [Int]?
        let gold: Int?
        let goldPerMin: Int?
        let goldSpent: Int?
        let goldT: [Int]?
        let heroDamage: Int?
        let heroHealing: Int?
        let heroId: Int?
        let item0: Int?
        let item1: Int?
        let item2: Int?
        let item3: Int?
        let item4: Int?
        let item5: Int?
        let kills: Int?
        let killsLog: [KillsLog]?
        let lastHits: Int?
        let leaverStatus: Int?
        let level: Int?
        let lhT: [Int]?
        let obsPlaced: Int?
        let partyId: Int?
        let partySize: Int?
        let pings: Int?
        let purchaseLog: [PurchaseLog]?
        let runePickups: Int?
        let runesLog: [RunesLog]?
        let senPlaced: Int?
        let stuns: Double?
        let times: [Date]?
        let towerDamage: Int?
        let xpPerMin: Int?
        let xpT: [Int]?
        let personaname: String?
        let name: String?
        let radiantWin: Bool?
        let startTime: Date?
        let duration: Int?
        let cluster: Int?
        let lobbyType: Int?
        let gameMode: Int?
        let patch: Int?
        let region: Int?
        let isRadiant: Bool?
        let win: Int?
        let lose: Int?
        let totalGold: Int?
        let totalXp: Int?
        let killsPerMin: Double?
        let kda: Int?
        let abandons: Int?
        let neutralKills: Int?
        let towerKills: Int?
        let courierKills: Int?
        let laneKills: Int?
        let heroKills: Int?
        let observerKills: Int?
        let sentryKills: Int?
        let roshanKills: Int?
        let necronomiconKills: Int?
        let ancientKills: Int?
        let buybackCount: Int?
        let observerUses: Int?
        let sentryUses: Int?
        let laneEfficiency: Double?
        let laneEfficiencyPct: Int?
        let lane: Int?
        let laneRole: Int?
        let isRoaming: Bool?
        let actionsPerMin: Int?
        let lifeStateDead: Int?
        let rankTier: Int?
//        let cosmetics: [Int]?

        //    let ability_uses
        //    let ability_targets
        //    let damage_targets
        //    let actions
        //    let additional_units
        //    let damage
        //    let damage_inflictor
        //    let damage_inflictor_received
        //    let damage_taken
        //    let gold_reasons
        //    let hero_hits
        //    let item_uses
        //    let kill_streaks
        //    let killed
        //    let killed_by
        //    let lane_pos
        //    let life_state
        //    let max_hero_hit
        //    let multi_kills
        //    let obs
        //    let obs_left_log
        //    let obs_log
        //    let permanent_buffs
        //    let purchase
        //    let runes
        //    let sen
        //    let sen_left_log
        //    let sen_log
        //    let xp_reasons
        //    let last_login : Date
        //    let purchase_time
        //    let first_purchase_time
        //    let item_win
        //    let item_usage
        //    let purchase_tpscroll
        //    let benchmarks
    }

    struct BuybackLog: Decodable, Equatable {
        let time: Date
        let slot: Int
        let playerSlot: Int?
    }

    struct ConnectionLog: Decodable, Equatable {
        let time: Date
        let event: String
        let playerSlot: Int?
    }

    struct KillsLog: Decodable, Equatable {
        let time: Date
        let key: String
    }

    struct PurchaseLog: Decodable, Equatable {
        let time: Date
        let key: String
        let charges: Int?
    }

    struct RunesLog: Decodable, Equatable {
        let time: Date
        let key: Int
    }
}
