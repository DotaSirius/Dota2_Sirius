import UIKit

protocol MatchesModuleViewInput: AnyObject {
    func updateState(matchesModuleState: MatchesModuleViewState)
    func updateSection(section: Int)
}

protocol MatchesModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsInSection(section: Int) -> Int
    func getData(indexPath: IndexPath) -> MatchCellType
    func cellTapped(indexPath: IndexPath)
}

final class MatchesModuleViewController: UIViewController  {
    private var output: MatchesModuleViewOutput?
    
    init(output: MatchesModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - MatchesModuleViewInput

extension MatchesModuleViewController: MatchesModuleViewInput {
    func updateState(matchesModuleState: MatchesModuleViewState) {
        // TODO
    }
    
    func updateSection(section: Int) {
        // TODO
    }
}
