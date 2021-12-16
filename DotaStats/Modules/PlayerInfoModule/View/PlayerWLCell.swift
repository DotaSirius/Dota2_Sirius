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

    private lazy var winNumber: UILabel = {
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

    private lazy var loseNumber: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var winStack: UIStackView = {
        let winStack = UIStackView()
        createStackView(stackView: winStack, axis: .vertical, spacing: 10)
        winStack.translatesAutoresizingMaskIntoConstraints = false
        return winStack
    }()

    private lazy var loseStack: UIStackView = {
        let loseStack = UIStackView()
        createStackView(stackView: loseStack, axis: .vertical, spacing: 10)
        loseStack.translatesAutoresizingMaskIntoConstraints = false
        return loseStack
    }()

    private lazy var winLoseStack: UIStackView = {
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

    func setUp() {
        self.selectionStyle = .none
        winStack.addArrangedSubview(winLabel)
        winStack.addArrangedSubview(winNumber)
        loseStack.addArrangedSubview(loseLabel)
        loseStack.addArrangedSubview(loseNumber)
        winLoseStack.addArrangedSubview(winStack)
        winLoseStack.addArrangedSubview(loseStack)
        contentView.addSubview(winLoseStack)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            winLoseStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            winLoseStack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            winLoseStack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension PlayerWLCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerWL(let data):
            winNumber.text = String(data.win)
            loseNumber.text = String(data.lose)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
