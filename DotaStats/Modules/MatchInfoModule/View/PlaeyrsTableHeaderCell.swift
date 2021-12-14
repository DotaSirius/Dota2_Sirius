import UIKit

final class PlayersTableHeaderCell: UITableViewCell {

    static let reuseIdentifier = "PlayersTableHeaderCell"

    private let playerInfoHeaderStack = UIStackView()

    private let playerNameHeaderLabel = UILabel()
    private let playerKillsHeaderLabel = UILabel()
    private let playerDeathsHeaderLabel = UILabel()
    private let playerAssitsHeaderLabel = UILabel()
    private let playerGoldHeaderLabel = UILabel()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setUpConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        [playerInfoHeaderStack].forEach { contentView.addSubview($0) }

        playerNameHeaderLabel.textColor = ColorPalette.mainText
        playerNameHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт

        playerKillsHeaderLabel.textColor = ColorPalette.win
        playerKillsHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт

        playerDeathsHeaderLabel.textColor = ColorPalette.lose
        playerDeathsHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт

        playerAssitsHeaderLabel.textColor = ColorPalette.subtitle
        playerAssitsHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт

        playerGoldHeaderLabel.textColor = ColorPalette.accent
        playerGoldHeaderLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт

    }

    func setUpConstraints() {
        [playerInfoHeaderStack].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        createStackView(stackView: playerInfoHeaderStack, axis: .horizontal, spacing: 3)
        [playerNameHeaderLabel, playerKillsHeaderLabel, playerDeathsHeaderLabel, playerAssitsHeaderLabel, playerGoldHeaderLabel].forEach{playerInfoHeaderStack.addArrangedSubview($0)}


        playerInfoHeaderStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        playerInfoHeaderStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        playerInfoHeaderStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        playerInfoHeaderStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    func createStackView(stackView:UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.trailing
        stackView.spacing = spacing
    }
}

extension PlayersTableHeaderCell: DetailedMatchInfoCellConfigurable {

    func configure(with data: MatchTableViewCellData) {
        playerNameHeaderLabel.text = "Player"
        playerKillsHeaderLabel.text  = "K"
        playerDeathsHeaderLabel.text = "D"
        playerAssitsHeaderLabel.text = "A"
        playerGoldHeaderLabel.text = "NET"
        }
}
