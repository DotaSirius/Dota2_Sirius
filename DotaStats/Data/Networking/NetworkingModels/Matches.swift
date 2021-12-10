struct Matches : Codable {
    let match_id : Int
    let barracks_status_dire : Int
    let barracks_status_radiant : Int
    let chat : [Chat]
    let cluster : Int
    //let cosmetics
    let dire_score : Int
    let draft_timings : [DraftTiming]
    let duration : Int
    let engine : Int
    let first_blood_time : Int
    let game_mode : Int
    let human_players : Int
    let leagueid : Int
    let lobby_type : Int
    let match_seq_num : Int
    let negative_votes : Int
//    let objectives
//    let picks_bans
    let positive_votes : Int
    //let radiant_gold_adv
    let radiant_score : Int
    let radiant_win : Bool
//    let radiant_xp_adv
    let start_time : Int
//    let teamfights
    let tower_status_dire : Int
    let tower_status_radiant : Int
    let version : Int
    let replay_salt : Int
    let series_id : Int
    let series_type : Int
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
    let replay_url : String

}


struct Chat : Codable {
    let time : Int
    let unit : String
    let key : String
    let slot : Int
    let player_slot : Int
}

struct  DraftTiming : Codable {
    let order : Int
    let pick : Bool
    let active_team : Int
    let hero_id : Int
    let player_slot : Int
    let extra_time : Int
    let total_time_taken : Int
}

struct Player : Codable {
    let match_id : Int
    let player_slot : Int
    let ability_upgrades_arr : [Int]
//    let ability_uses
//    let ability_targets
//    let damage_targets
    let account_id : Int
//    let actions
//    let additional_units
    let assists : Int
    let backpack_0 : Int
    let backpack_1 : Int
    let backpack_2 : Int
    let buyback_log : [BuybackLog]
    let camps_stacked : Int
    let connection_log : [ConnectionLog]
    let creeps_stacked : Int
//    let damage
//    let damage_inflictor
//    let damage_inflictor_received
//    let damage_taken
    let deaths : Int
    let denies : Int
    let dn_t : [Int]
    let gold : Int
    let gold_per_min : Int
//    let gold_reasons
    let gold_spent : Int
    let gold_t : [Int]
    let hero_damage : Int
    let hero_healing : Int
//    let hero_hits
    let hero_id : Int
    let item_0 : Int
    let item_1 : Int
    let item_2 : Int
    let item_3 : Int
    let item_4 : Int
    let item_5 : Int
//    let item_uses
//    let kill_streaks
//    let killed
//    let killed_by
    let kills : Int
    let kills_log : [KillsLog]
//    let lane_pos
    let last_hits : Int
    let leaver_status : Int
    let level : Int
    let lh_t : [Int]
//    let life_state
//    let max_hero_hit
//    let multi_kills
//    let obs
//    let obs_left_log
//    let obs_log
    let obs_placed : Int
    let party_id : Int
//    let permanent_buffs
    let pings : Int
//    let purchase
    let purchase_log : [PurchaseLog]
    let rune_pickups : Int
//    let runes
    let runes_log : [RunesLog]
//    let sen
//    let sen_left_log
//    let sen_log
    let sen_placed : Int
    let stuns : Int
    let times : [Int]
    let tower_damage : Int
    let xp_per_min : Int
//    let xp_reasons
    let xp_t : [Int]
    let personaname : String
    let name : String
//    let last_login : DateFormatter
    let radiant_win : Bool
    let start_time : Int
    let duration : Int
    let cluster : Int
    let lobby_type : Int
    let game_mode : Int
    let patch : Int
    let region : Int
    let isRadiant : Bool
    let win : Int
    let lose : Int
    let total_gold : Int
    let total_xp : Int
    let kills_per_min : Int
    let kda : Int
    let abandons : Int
    let neutral_kills : Int
    let tower_kills : Int
    let courier_kills : Int
    let lane_kills : Int
    let hero_kills : Int
    let observer_kills : Int
    let sentry_kills : Int
    let roshan_kills : Int
    let necronomicon_kills : Int
    let ancient_kills : Int
    let buyback_count : Int
    let observer_uses : Int
    let sentry_uses : Int
    let lane_efficiency : Int
    let lane_efficiency_pct : Int
    let lane : Int
    let lane_role : Int
    let is_roaming : Bool
//    let purchase_time
//    let first_purchase_time
//    let item_win
//    let item_usage
//    let purchase_tpscroll
    let actions_per_min : Int
    let life_state_dead : Int
    let rank_tier : Int
    let cosmetics : [Int]
//    let benchmarks
}

struct BuybackLog : Codable {
    let time : Int
    let slot : Int
    let player_slot : Int
}

struct ConnectionLog : Codable {
    let time : Int
    let event : String
    let player_slot : Int
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
