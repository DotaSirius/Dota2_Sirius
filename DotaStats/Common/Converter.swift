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

    static func convertWinrateToColor(_ winrate: Float) -> UIColor {
        switch winrate {
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

    static func convertDate(_ date: String?) -> String {
        if date != nil {
            guard let unwrappedTime = date else {
                return ""
            }
            let formatterD = DateFormatter()
            formatterD.locale = Locale(identifier: "en_US_POSIX")
            formatterD.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            let date = formatterD.date(from: unwrappedTime)

            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            let realDate = formatter.localizedString(
                for: date!,
                relativeTo: Date()
            )
            return realDate
        } else {
            return "long ago"
        }
    }
}
