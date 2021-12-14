import Foundation

extension DateFormatter {
    static var ISO8601WithSecondsFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"

        return formatter
    }
}
