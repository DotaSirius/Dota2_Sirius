import UIKit

protocol PlayersModuleViewInput: AnyObject {
    func showLoading()
    func showPlayers(_ players: [Player])
}

protocol PlayersModuleViewOutput: AnyObject {
    func players() -> [Player]
    func playersByName(_ name: String) -> [Player]
}

final class PlayersModuleViewController: UIViewController  {
    private var output: PlayersModuleViewOutput?
    
    init(output: PlayersModuleViewOutput) {
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

// MARK: - PlayersModuleViewInput
extension PlayersModuleViewController: PlayersModuleViewInput {
    func showLoading() {
        // TODO
    }
    
    func showPlayers(_ players: [Player]) {
        // TODO
    }
}
