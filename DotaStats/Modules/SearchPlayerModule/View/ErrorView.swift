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

    @available(*, unavailable)
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
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
