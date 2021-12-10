struct Players {
    let tracked_until : String
    let solo_competitive_rank : String
    let competitive_rank : String
    let rank_tier : Int
    let leaderboard_rank : Int
    let mmr_estimate : Estimate
    let profile : Profile
    

}

struct Estimate {
    let estimate : Int
}

struct Profile {
    let account_id : Int
    let personaname : String
    let name : String
    let plus : Bool
    let cheese : Int
    let steamid : String
    let avatar : String
    let avatarmedium : String
    let avatarfull : String
    let profileurl : String
    let last_login : String
    let loccountrycode : String
    let is_contributor : Bool
}
