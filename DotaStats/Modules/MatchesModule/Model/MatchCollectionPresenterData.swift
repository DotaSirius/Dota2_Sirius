import Foundation

struct MatchCollectionPresenterData {
    var rowSection: RowSection
    var isOpen: Bool
    var matchCellType: MatchCellType
    var id: Int
    
    struct RowSection {
        var section: Int
        var row: Int
    }
}
