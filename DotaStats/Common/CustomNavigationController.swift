import UIKit

class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    init(rootViewController: UIViewController, title: String) {
        super.init(rootViewController: rootViewController)

        rootViewController.title = title
        rootViewController.view?.backgroundColor = ColorPalette.mainBackground
        navigationBar.tintColor = ColorPalette.text
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
