import UIKit

final class TeamShortInfo {
    private enum Constant {
        static let minutes: TimeInterval = 60
        static let tenMinutesSeconds: TimeInterval = 10 * minutes
        static let hourSeconds: TimeInterval = 60 * 60
        static let oneDaySeconds: TimeInterval = 86400
        static let weekSeconds: TimeInterval = 7 * oneDaySeconds
        static let monthSeconds: TimeInterval = 4 * weekSeconds
        static let yearSeconds: TimeInterval = 12 * monthSeconds
    }

    var num: String = "..."
    let teamId: Int
    let logoUrl: String?
    let name: String

    private let lastMatchTime: Date
    var recentActivity: String {
        dateToString(lastMatchTime)
    }

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
        lastMatchTime = teamResult.lastMatchTime
        name = teamResult.name.isEmpty ? "Anonymous Team" : teamResult.name
        rating = teamResult.rating
        winrate = Float(teamResult.wins) / Float(teamResult.losses + teamResult.wins) * 100
    }

    private func convertRatingToColor(_ rating: Float) -> UIColor {
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

    private func convertWinrateToColor(_ winrate: Float) -> UIColor {
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

    private func dateToString(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let now = Date().timeIntervalSince1970
        let diff = now - date.timeIntervalSince1970
        switch diff {
        case 0..<Constant.tenMinutesSeconds:
            return "меньше 10 минут"
        case Constant.tenMinutesSeconds..<Constant.hourSeconds:
            return "меньше часа"
        case Constant.hourSeconds..<Constant.oneDaySeconds:
            return "меньше дня"
        case Constant.oneDaySeconds..<Constant.weekSeconds:
            return "меньше недели"
        case Constant.weekSeconds..<Constant.monthSeconds:
            return "меньше месяца"
        default:
            return "меньше года"
        }
    }
}
