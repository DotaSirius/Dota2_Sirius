import Foundation
struct ProMatches : Decodable {
    let matches : [Match]
}

struct Match : Decodable {
    let matchId : Int
    let duration : Int
    let startTime : Date
    let radiantTeamId : Int?
    let radiantName : String?
    let direTeamId : Int
    let direName : String
    let leagueid : Int
    let leagueName : String
    let seriesId : Int
    let seriesType : Int
    let radiantScore : Int
    let direScore : Int
    let radiantWin : Bool
    let radiant : Bool?
}

//let jsonData: Data
//let jsonDecoder = JSONDecoder()
//jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//let result = try jsonDecoder.decode(Match.self, from: jsonData)
//есть милисекунды
