import UIKit

final class PlayerWLCell: UITableViewCell {
    static let reuseIdentifier = "PlayerWLCell"

    // MARK: - Properties

    private lazy var winLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.win
        name.font = UIFont.systemFont(ofSize: 20)
        name.text = "WINS"
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var winNumberLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.win
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var loseLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 20)
        name.text = "LOSES"
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var loseNumberLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var winStackView: UIStackView = {
        let winStack = UIStackView()
        createStackView(stackView: winStack, axis: .vertical, spacing: 10)
        winStack.translatesAutoresizingMaskIntoConstraints = false
        return winStack
    }()

    private lazy var loseStackView: UIStackView = {
        let loseStack = UIStackView()
        createStackView(stackView: loseStack, axis: .vertical, spacing: 10)
        loseStack.translatesAutoresizingMaskIntoConstraints = false
        return loseStack
    }()

    private lazy var winLoseStackView: UIStackView = {
        let winLoseStack = UIStackView()
        createStackView(stackView: winLoseStack, axis: .horizontal, spacing: 50)
        winLoseStack.translatesAutoresizingMaskIntoConstraints = false
        return winLoseStack
    }()

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setUp()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Set up constraints

    private func setUp() {
        selectionStyle = .none
        winStackView.addArrangedSubview(winLabel)
        winStackView.addArrangedSubview(winNumberLabel)
        loseStackView.addArrangedSubview(loseLabel)
        loseStackView.addArrangedSubview(loseNumberLabel)
        winLoseStackView.addArrangedSubview(winStackView)
        winLoseStackView.addArrangedSubview(loseStackView)
        contentView.addSubview(winLoseStackView)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            winLoseStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            winLoseStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            winLoseStackView.bottomAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
                constant: -10
            ),
            winLoseStackView.trailingAnchor.constraint(
                lessThanOrEqualTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -10
            ),
            winLoseStackView.leadingAnchor.constraint(
                greaterThanOrEqualTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            )
        ])
    }
}

extension PlayerWLCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerWL(let data):
            winNumberLabel.text = String(data.win)
            loseNumberLabel.text = String(data.lose)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
