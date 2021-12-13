import Foundation

struct MatchCollectionPresenterData {
    var rowSection: RowSection
    var isOpen: Bool
    var matchCellType: MatchCellType
    
    struct RowSection {
        var section: Int
        var row: Int
    }
}
