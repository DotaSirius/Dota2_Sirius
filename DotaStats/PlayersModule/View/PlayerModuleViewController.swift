import UIKit

class PlayerModuleViewController: UIViewController {
    
    private var presenter: PlayersModuleOutput
    
    init(presenter: PlayersModuleOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension PlayerModuleViewController: PlayersModuleInput {
    func showLoading() {
        <#code#>
    }
    
    func showPlayers(_ players: [Player]) {
        <#code#>
    }
}
