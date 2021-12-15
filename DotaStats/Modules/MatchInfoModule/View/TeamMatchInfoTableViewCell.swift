import UIKit

final class TeamMatchInfoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "TeamMatchInfoTableViewCell"

    private lazy var teamNameLabel: UILabel = {
        let teamNameLabel = UILabel()
        teamNameLabel.textColor = ColorPalette.mainText
        teamNameLabel.font = UIFont.systemFont(ofSize: 20)
        teamNameLabel.numberOfLines = 3
        teamNameLabel.textAlignment = .center
        teamNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return teamNameLabel
    }()

    private lazy var teamWinLabel: UILabel = {
        let teamWinLabel = UILabel()
        teamWinLabel.textColor = ColorPalette.win
        teamWinLabel.font = UIFont.systemFont(ofSize: 20)
        return teamWinLabel
    }()

    private lazy var teamNameWinStack: UIStackView = {
        let teamNameWinStack = UIStackView()
        createStackView(stackView: teamNameWinStack, axis: .horizontal, spacing: 8)
        teamNameWinStack.translatesAutoresizingMaskIntoConstraints = false
        return teamNameWinStack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup() {
        selectionStyle = .none
        contentView.addSubview(teamNameWinStack)
        [teamNameLabel,
         teamWinLabel
        ].forEach {
            teamNameWinStack.addArrangedSubview($0)
        }
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = spacing
    }

     func setUpConstraints() {
         teamNameWinStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
         teamNameWinStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
         teamNameWinStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
         teamNameWinStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
}

extension TeamMatchInfoTableViewCell:  DetailedMatchInfoCellConfigurable {
        func configure(with data: MatchTableViewCellData) {
            switch data.type {
            case .teamMatchInfo(let data):
                teamNameLabel.text = data.teamNameLabelText
                teamWinLabel.text = data.teamWinLabel
            default : break
           }
        }
    }
