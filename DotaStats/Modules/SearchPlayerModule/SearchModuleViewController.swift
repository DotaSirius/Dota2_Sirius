import UIKit

enum SearchPlayerModuleError: Error {
    // TODO: correct error types
    case sampleError
}

protocol SearchPlayerModuleViewInput: AnyObject {
    func updateState(_ state: SearchPlayerModuleViewState)
}

protocol SearchPlayerModuleViewOutput: AnyObject {
    var count: Int { get }
    func getData(indexPath: IndexPath) -> Player
    func playerSelected(_ player: Player)
    func search(_ name: String)
}

class SearchPlayerModuleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - SearchModuleViewInput

extension SearchPlayerModuleViewController: SearchPlayerModuleInput {
    func updateState(_ state: SearchPlayerModuleViewState) {
        // TODO: make update view
        switch state {
        case .loading:
            // TODO: show activity indicator
            break
        case .success(let array):
            // TODO: show data
            print(array)
        case .failure(let searchModuleError):
            // TODO: show error
            print(searchModuleError)
        }
    }
}
