import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
       prefix(1).uppercased() + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
