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
        Converter.convertDate(lastMatchTime)
    }

    let rating: Float
    var ratingColor: UIColor {
        Converter.convertRatingToColor(rating)
    }

    private let winRate: Float
    var winRateString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        let formatingWinRate = formatter.string(from: NSNumber(value: winRate)) ?? "0"
        return formatingWinRate + "%"
    }

    var winRateColor: UIColor {
        Converter.convertWinRateToColor(winRate)
    }

    init(from teamResult: TeamResult) {
        teamId = teamResult.teamId
        logoUrl = teamResult.logoUrl
        lastMatchTime = teamResult.lastMatchTime
        name = teamResult.name
        rating = teamResult.rating
        winRate = Float(teamResult.wins) / Float(teamResult.losses + teamResult.wins) * 100
    }

    private func recentActivityDateToString(_ date: Date) -> String {
        let now = Date().timeIntervalSince1970
        let diff = now - date.timeIntervalSince1970
        switch diff {
        case 0..<Constant.hourSeconds:
            let minutes = Int(diff / Constant.minutes)
            return minutes == 1 ? "a minute ago" : "\(minutes) minutes ago"
        case Constant.hourSeconds..<Constant.oneDaySeconds:
            let hours = Int(diff / Constant.hourSeconds)
            return hours == 1 ? "an hour ago" : "\(hours) hours ago"
        case Constant.oneDaySeconds..<Constant.monthSeconds:
            let days = Int(diff / Constant.oneDaySeconds)
            return days == 1 ? "a day ago" : "\(days) days ago"
        case Constant.monthSeconds..<Constant.yearSeconds:
            let months = Int(diff / Constant.monthSeconds)
            return months == 1 ? "a month ago" : "\(months) months ago"
        default:
            return ""
        }
    }
}
