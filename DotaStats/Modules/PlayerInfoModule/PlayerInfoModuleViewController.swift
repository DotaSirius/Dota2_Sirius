import UIKit

protocol PlayerInfoModuleViewInput: AnyObject {
    func update(state: PlayerInfoModuleViewState)
}

protocol PlayerInfoModuleViewOutput: AnyObject {
    func getMainData()
}

final class PlayerInfoModuleViewController: UIViewController {
}

extension PlayerInfoModuleViewController: PlayerInfoModuleViewInput {
    func update(state: PlayerInfoModuleViewState) {
        //todo
    }
}
