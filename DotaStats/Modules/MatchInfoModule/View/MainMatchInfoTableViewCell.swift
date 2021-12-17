import UIKit

final class MainMatchInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MainMatchInfoTableViewCell"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8

    private lazy var winnersLabel: UILabel = {
        let winnersLabel = UILabel()
        winnersLabel.font = UIFont.systemFont(ofSize: 30)
        winnersLabel.numberOfLines = 3
        winnersLabel.textAlignment = .center
        winnersLabel.translatesAutoresizingMaskIntoConstraints = false
        return winnersLabel
    }()

    private lazy var firstTeamScoreLabel: UILabel = {
        let firstTeamScoreLabel = UILabel()
        firstTeamScoreLabel.textColor = ColorPalette.win
        firstTeamScoreLabel.font = UIFont.systemFont(ofSize: 30)
        firstTeamScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return firstTeamScoreLabel
    }()

    private lazy var secondTeamScoreLabel: UILabel = {
        let secondTeamScoreLabel = UILabel()
        secondTeamScoreLabel.textColor = ColorPalette.lose
        secondTeamScoreLabel.font = UIFont.systemFont(ofSize: 30)
        secondTeamScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return secondTeamScoreLabel
    }()

    private lazy var gameTimeLabel: UILabel = {
        let gameTimeLabel = UILabel()
        gameTimeLabel.textColor = ColorPalette.mainText
        gameTimeLabel.font = UIFont.systemFont(ofSize: 20)
        gameTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return gameTimeLabel
    }()

    private lazy var matchEndTimeLabel: UILabel = {
        let matchEndTimeLabel = UILabel()
        matchEndTimeLabel.textColor = ColorPalette.subtitle
        matchEndTimeLabel.font = UIFont.systemFont(ofSize: 15)
        matchEndTimeLabel.numberOfLines = 3
        matchEndTimeLabel.textAlignment = .center
        matchEndTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return matchEndTimeLabel
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
        [winnersLabel,
         gameTimeLabel,
         matchEndTimeLabel,
         firstTeamScoreLabel,
         secondTeamScoreLabel].forEach {
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            winnersLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            winnersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            winnersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),

            firstTeamScoreLabel.topAnchor.constraint(equalTo: winnersLabel.bottomAnchor, constant: smallInset),
            firstTeamScoreLabel.trailingAnchor.constraint(equalTo: gameTimeLabel.leadingAnchor, constant: -inset),

            secondTeamScoreLabel.topAnchor.constraint(equalTo: winnersLabel.bottomAnchor, constant: smallInset),
            secondTeamScoreLabel.leadingAnchor.constraint(equalTo: gameTimeLabel.trailingAnchor, constant: inset),

            gameTimeLabel.centerYAnchor.constraint(equalTo: firstTeamScoreLabel.centerYAnchor),
            gameTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            matchEndTimeLabel.topAnchor.constraint(equalTo: firstTeamScoreLabel.bottomAnchor, constant: smallInset),
            matchEndTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            matchEndTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            matchEndTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension MainMatchInfoTableViewCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .mainMatchInfo(let data):
            winnersLabel.text = data.winnersLabelText
            if winnersLabel.text == "Radiant Victory" {
                winnersLabel.textColor = ColorPalette.win
            } else {
                winnersLabel.textColor = ColorPalette.lose
            }
            gameTimeLabel.text = data.gameTimeLabelText
            firstTeamScoreLabel.text = data.firstTeamScoreLabelText
            secondTeamScoreLabel.text = data.secondTeamScoreLabelText
            matchEndTimeLabel.text = data.matchEndTimeLabelText
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
