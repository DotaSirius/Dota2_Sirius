struct Matches : Codable {
    let matchId: Int
    let barracksStatusDire: Int
    let barracksStatusRadiant: Int
    let chat : [Chat]
    let cluster : Int
    //let cosmetics
    let direScore: Int
    let draftTimings: [DraftTiming]
    let duration : Int
    let engine : Int
    let firstBloodTime: Int
    let gameMode : Int
    let humanPlayers : Int
    let leagueid : Int
    let lobbyType : Int
    let matchSeqNum : Int
    let negativeVotes : Int
//    let objectives
//    let picks_bans
    let positiveVotes : Int
    //let radiant_gold_adv
    let radiantScore : Int
    let radiantWin : Bool
//    let radiant_xp_adv
    let startTime : Int
//    let teamfights
    let towerStatusDire : Int
    let towerStatusRadiant : Int
    let version : Int
    let replaySalt : Int
    let seriesId : Int
    let seriesType : Int
//    let radiant_team
//    let dire_team
//    let league
    let skill : Int
    let players : [Player]
    let patch : Int
    let region : Int
//    let all_word_counts
//    let my_word_counts
    let `throw` : Int
    let comeback : Int
    let loss : Int
    let win : Int
    let replayUrl : String

}


struct Chat : Codable {
    let time : Int
    let unit : String
    let key : String
    let slot : Int
    let playerSlot : Int
}

struct  DraftTiming : Codable {
    let order : Int
    let pick : Bool
    let activeTeam : Int
    let heroId : Int
    let playerSlot : Int
    let extraTime : Int
    let totalTimeTaken : Int
}

struct Player : Codable {
    let matchId : Int
    let playerSlot : Int
    let abilityUpgradesArr : [Int]
//    let ability_uses
//    let ability_targets
//    let damage_targets
    let accountId : Int
//    let actions
//    let additional_units
    let assists : Int
    let Backpack0 : Int
    let Backpack1 : Int
    let Backpack2 : Int
    let buybackLog : [BuybackLog]
    let campsStacked : Int
    let connectionLog : [ConnectionLog]
    let creepsStacked : Int
//    let damage
//    let damage_inflictor
//    let damage_inflictor_received
//    let damage_taken
    let deaths : Int
    let denies : Int
    let dnT : [Int]
    let gold : Int
    let goldPerMin : Int
//    let gold_reasons
    let goldSpent : Int
    let goldT : [Int]
    let heroDamage : Int
    let heroHealing : Int
//    let hero_hits
    let heroId : Int
    let Item0 : Int
    let Item1 : Int
    let Item2 : Int
    let Item3 : Int
    let Item4 : Int
    let Item5 : Int
//    let item_uses
//    let kill_streaks
//    let killed
//    let killed_by
    let kills : Int
    let killsLog : [KillsLog]
//    let lane_pos
    let lastHits : Int
    let leaverStatus : Int
    let level : Int
    let lhT : [Int]
//    let life_state
//    let max_hero_hit
//    let multi_kills
//    let obs
//    let obs_left_log
//    let obs_log
    let obsPlaced : Int
    let partyId : Int
//    let permanent_buffs
    let pings : Int
//    let purchase
    let purchaseLog : [PurchaseLog]
    let runePickups : Int
//    let runes
    let runesLog : [RunesLog]
//    let sen
//    let sen_left_log
//    let sen_log
    let senPlaced : Int
    let stuns : Int
    let times : [Int]
    let towerDamage : Int
    let xpPerMin : Int
//    let xp_reasons
    let xpT : [Int]
    let personaname : String
    let name : String
//    let last_login : DateFormatter
    let radiantWin : Bool
    let startTime : Int
    let duration : Int
    let cluster : Int
    let lobbyType : Int
    let gameMode : Int
    let patch : Int
    let region : Int
    let isRadiant : Bool
    let win : Int
    let lose : Int
    let totalGold : Int
    let totalXp : Int
    let killsPerMin : Int
    let kda : Int
    let abandons : Int
    let neutralKills : Int
    let towerKills : Int
    let courierKills : Int
    let laneKills : Int
    let heroKills : Int
    let observerKills : Int
    let sentryKills : Int
    let roshanKills : Int
    let necronomiconKills : Int
    let ancientKills : Int
    let buybackCount : Int
    let observerUses : Int
    let sentryUses : Int
    let laneEfficiency : Int
    let laneEfficiencyPct : Int
    let lane : Int
    let laneRole : Int
    let isRoaming : Bool
//    let purchase_time
//    let first_purchase_time
//    let item_win
//    let item_usage
//    let purchase_tpscroll
    let actionsPerMin : Int
    let lifeStateDead : Int
    let rankTier : Int
    let cosmetics : [Int]
//    let benchmarks
}

struct BuybackLog : Codable {
    let time : Int
    let slot : Int
    let playerSlot : Int
}

struct ConnectionLog : Codable {
    let time : Int
    let event : String
    let playerSlot : Int
}


struct KillsLog : Codable {
    let time : Int
    let key : String
}

struct PurchaseLog : Codable {
    let time : Int
    let key : String
    let charges : Int
}

struct RunesLog : Codable {
    let time : Int
    let key : Int
}
