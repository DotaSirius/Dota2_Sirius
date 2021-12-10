struct Players {
    let trackedUntil : String
    let soloCompetitiveRank : String
    let competitiveRank : String
    let rankTier : Int
    let leaderboardRank : Int
    let mmrEstimate : Estimate
    let profile : Profile
    

}

struct Estimate {
    let estimate : Int
}

struct Profile {
    let accountId : Int
    let personaname : String
    let name : String
    let plus : Bool
    let cheese : Int
    let steamid : String
    let avatar : String
    let avatarmedium : String
    let avatarfull : String
    let profileurl : String
    let lastLogin : String
    let loccountrycode : String
    let is_contributor : Bool
}
