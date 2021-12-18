import UIKit

final class Converter {
    static func convertRatingToColor(_ rating: Float) -> UIColor {
        switch rating {
        case 0...300:
            return .red
        case 300...600:
            return .orange
        case 600...900:
            return .yellow
        case 900...1200:
            return .green
        case 1200...1500:
            return .cyan
        default:
            return .systemIndigo
        }
    }

    static func convertWinRateToColor(_ winRate: Float) -> UIColor {
        switch winRate {
        case 0...40:
            return .red
        case 40...48:
            return .orange
        case 48...53:
            return .yellow
        case 53...58:
            return .green
        case 58...63:
            return .cyan
        default:
            return .systemIndigo
        }
    }
    
    static func convertGameAmountToColor(_ rating: Float) -> UIColor {
        switch rating {
        case 0...30:
            return .red
        case 30...120:
            return .orange
        case 120...200:
            return .yellow
        case 200...320:
            return .green
        case 320...450:
            return .cyan
        default:
            return .systemIndigo
        }
    }


    static func convertDate(_ date: Date?) -> String {
        guard let date = date else { return "long ago" }
        let relativeDateFormatter = RelativeDateTimeFormatter()
        relativeDateFormatter.dateTimeStyle = .named
        let dateString = relativeDateFormatter.localizedString(
            for: date,
            relativeTo: Date()
        )
        return dateString
    }
}
