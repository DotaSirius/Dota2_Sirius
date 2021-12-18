import UIKit

final class PlayersTableHeaderCell: UITableViewCell {
    static let reuseIdentifier = "PlayersTableHeaderCell"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8
    let labelWidth: CGFloat = 30

    private lazy var playerNameHeaderLabel: UILabel = {
        let playerNameHeaderLabel = UILabel()
        playerNameHeaderLabel.textColor = ColorPalette.mainText
        playerNameHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerNameHeaderLabel.textAlignment = .left
        playerNameHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerNameHeaderLabel
    }()

    private lazy var playerKillsHeaderLabel: UILabel = {
        let playerKillsHeaderLabel = UILabel()
        playerKillsHeaderLabel.textColor = ColorPalette.win
        playerKillsHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerKillsHeaderLabel.textAlignment = .center
        playerKillsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerKillsHeaderLabel
    }()

    private lazy var playerDeathsHeaderLabel: UILabel = {
        let playerDeathsHeaderLabel = UILabel()
        playerDeathsHeaderLabel.textColor = ColorPalette.lose
        playerDeathsHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerDeathsHeaderLabel.textAlignment = .center
        playerDeathsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerDeathsHeaderLabel
    }()

    private lazy var playerAssitsHeaderLabel: UILabel = {
        let playerAssitsHeaderLabel = UILabel()
        playerAssitsHeaderLabel.textColor = ColorPalette.subtitle
        playerAssitsHeaderLabel.font = UIFont.systemFont(ofSize: 15)
        playerAssitsHeaderLabel.textAlignment = .center
        playerAssitsHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerAssitsHeaderLabel
    }()

    private lazy var playerGoldHeaderLabel: UILabel = {
        let playerGoldHeaderLabel = UILabel()
        playerGoldHeaderLabel.textColor = ColorPalette.accent
        playerGoldHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        playerGoldHeaderLabel.textAlignment = .center
        playerGoldHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerGoldHeaderLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        selectionStyle = .none
        [
            playerNameHeaderLabel,
            playerGoldHeaderLabel,
            playerAssitsHeaderLabel,
            playerDeathsHeaderLabel,
            playerKillsHeaderLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            playerNameHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            playerNameHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            playerNameHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallInset),
            playerNameHeaderLabel.trailingAnchor.constraint(equalTo: playerKillsHeaderLabel.leadingAnchor),

            playerGoldHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playerGoldHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            playerGoldHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallInset),
            playerGoldHeaderLabel.widthAnchor.constraint(equalToConstant: labelWidth),

            playerAssitsHeaderLabel.trailingAnchor.constraint(
                equalTo: playerGoldHeaderLabel.leadingAnchor, constant: -smallInset
            ),
            playerAssitsHeaderLabel.widthAnchor.constraint(equalTo: playerGoldHeaderLabel.widthAnchor),
            playerAssitsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            playerAssitsHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallInset),

            playerDeathsHeaderLabel.trailingAnchor.constraint(
                equalTo: playerAssitsHeaderLabel.leadingAnchor, constant: -smallInset
            ),
            playerDeathsHeaderLabel.widthAnchor.constraint(equalTo: playerGoldHeaderLabel.widthAnchor),
            playerDeathsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            playerDeathsHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallInset),

            playerKillsHeaderLabel.trailingAnchor.constraint(
                equalTo: playerDeathsHeaderLabel.leadingAnchor, constant: -smallInset
            ),
            playerKillsHeaderLabel.widthAnchor.constraint(equalTo: playerGoldHeaderLabel.widthAnchor),
            playerKillsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            playerKillsHeaderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallInset)
        ])
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }
}

extension PlayersTableHeaderCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        playerNameHeaderLabel.text = "Player"
        playerKillsHeaderLabel.text = "K"
        playerDeathsHeaderLabel.text = "D"
        playerAssitsHeaderLabel.text = "A"
        playerGoldHeaderLabel.text = "NET"
    }
}
