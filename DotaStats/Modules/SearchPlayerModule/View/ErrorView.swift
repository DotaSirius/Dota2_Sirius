import Foundation
import UIKit

final class ErrorView: UIView {
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.mainText
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.text = "200"
        return label
    }()

    var text: String? {
        didSet {
            errorLabel.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = ColorPalette.error
        isUserInteractionEnabled = true
        addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            // errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

// MARK: Show/hide errors functions

//
//
// func showError() {
//    UIView.animate(withDuration: 0.5,
//                   delay: 0.0,
//                   options: [.curveEaseInOut]) {
//        self.errorConstraint?.constant = 35
//        self.errorView.alpha = 1
//        self.view.layoutIfNeeded()
//    }
// }
//
// func hideError() {
//    UIView.animate(withDuration: 0.5,
//                   delay: 0.0,
//                   options: [.curveEaseOut]) {
//        self.errorConstraint?.constant = 0
//        self.errorView.alpha = 0
//        self.view.layoutIfNeeded()
//    }
// }
//

// MARK: Написать это в viewDidLoad()

// errorView.isUserInteractionEnabled = true
// let tapActionHideError = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_ :)))
// errorView.addGestureRecognizer(tapActionHideError)
