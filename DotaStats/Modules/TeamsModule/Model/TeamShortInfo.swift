import UIKit

struct TeamShortInfo {
    let teamId: Int
    let logoUrl: String?
    let name: String

    let rating: Float
    var ratingColor: UIColor {
        convertRatingToColor(rating)
    }
    
    let winrate: Float
    var winrateColor: UIColor {
        convertWinrateToColor(winrate)
    }

    init(from teamResult: TeamResult) {
        teamId = teamResult.teamId
        logoUrl = teamResult.logoUrl
        name = teamResult.name
        rating = teamResult.rating
        winrate = Float(teamResult.wins) / Float(teamResult.losses + teamResult.wins) * 100
    }
}

func convertRatingToColor(_ rating: Float) -> UIColor {
    switch rating {
    case 0...300:
        return .brown
    case 300...600:
        return .red
    case 600...900:
        return .orange
    case 900...1200:
        return .yellow
    case 1200...1400:
        return .green
    default:
        return .systemIndigo
    }
}

func convertWinrateToColor(_ winrate: Float) -> UIColor {
    switch winrate {
    case 0...30:
        return .brown
    case 30...40:
        return .red
    case 40...48:
        return .orange
    case 48...53:
        return .yellow
    case 53...58:
        return .green
    default:
        return .systemIndigo
    }
}
