import UIKit

protocol MatchesModuleViewInput: AnyObject {
    func updateState()
    func updateSection()
}

protocol MatchesModuleViewOutput: AnyObject {
    func getSectionCount()
    func getRowsInSection()
    func getData()
    func cellTapped()
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
    func updateState() {
        // TODO
    }
    
    func updateSection() {
        // TODO
    }
}
