import UIKit

final class MainTeamInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MainTeamInfoTableViewCell"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8

    private lazy var winsStackView: UIStackView = {
        let winsStackView = UIStackView()
        createStackView(stackView: winsStackView, axis: .vertical, spacing: 8)
        winsStackView.translatesAutoresizingMaskIntoConstraints = false
        return winsStackView
    }()

    private lazy var lossesStackView: UIStackView = {
        let lossesStackView = UIStackView()
        createStackView(stackView: lossesStackView, axis: .vertical, spacing: 8)
        lossesStackView.translatesAutoresizingMaskIntoConstraints = false
        return lossesStackView
    }()

    private lazy var ratingStackView: UIStackView = {
        let ratingStackView = UIStackView()
        createStackView(stackView: ratingStackView, axis: .vertical, spacing: 8)
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        return ratingStackView
    }()

    private lazy var teamNameLabel: UILabel = {
        let teamNameLabel = UILabel()
        teamNameLabel.textColor = ColorPalette.mainText
        teamNameLabel.font = UIFont.systemFont(ofSize: 30)
        teamNameLabel.numberOfLines = 3
        teamNameLabel.textAlignment = .center
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return teamNameLabel
    }()

    private lazy var winsNameLabel: UILabel = {
        let winsNameLabel = UILabel()
        winsNameLabel.text = "WINS"
        winsNameLabel.textColor = ColorPalette.text
        winsNameLabel.font = UIFont.systemFont(ofSize: 20)
        winsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return winsNameLabel
    }()

    private lazy var winsLabel: UILabel = {
        let winsLabel = UILabel()
        winsLabel.textColor = ColorPalette.win
        winsLabel.font = UIFont.systemFont(ofSize: 20)
        winsLabel.translatesAutoresizingMaskIntoConstraints = false
        return winsLabel
    }()

    private lazy var lossesNameLabel: UILabel = {
        let lossesNameLabel = UILabel()
        lossesNameLabel.text = "LOSSES"
        lossesNameLabel.textColor = ColorPalette.text
        lossesNameLabel.font = UIFont.systemFont(ofSize: 20)
        lossesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return lossesNameLabel
    }()

    private lazy var lossesLabel: UILabel = {
        let lossesLabel = UILabel()
        lossesLabel.textColor = ColorPalette.lose
        lossesLabel.font = UIFont.systemFont(ofSize: 20)
        lossesLabel.translatesAutoresizingMaskIntoConstraints = false
        return lossesLabel
    }()

    private lazy var ratingNameLabel: UILabel = {
        let ratingNameLabel = UILabel()
        ratingNameLabel.text = "RATING"
        ratingNameLabel.textColor = ColorPalette.text
        ratingNameLabel.font = UIFont.systemFont(ofSize: 20)
        ratingNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingNameLabel
    }()

    private lazy var ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = ColorPalette.mainText
        ratingLabel.font = UIFont.systemFont(ofSize: 20)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratingLabel
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
        [teamNameLabel,
         winsStackView,
         lossesStackView,
         ratingStackView
        ].forEach {
            contentView.addSubview($0)
        }

        [winsNameLabel,
         winsLabel].forEach {
            winsStackView.addArrangedSubview($0)
        }

        [lossesNameLabel,
         lossesLabel].forEach {
            lossesStackView.addArrangedSubview($0)
        }

        [ratingNameLabel,
         ratingLabel].forEach {
            ratingStackView.addArrangedSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            teamNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            teamNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            teamNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),

            lossesStackView.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: inset),
            lossesStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lossesStackView.widthAnchor.constraint(equalToConstant: 100),
            lossesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),

            winsStackView.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: inset),
            winsStackView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -70),
            winsStackView.widthAnchor.constraint(equalToConstant: 100),
            lossesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),

            ratingStackView.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor, constant: inset),
            ratingStackView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 70),
            ratingStackView.widthAnchor.constraint(equalToConstant: 100),
            lossesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }
}

extension MainTeamInfoTableViewCell: DetailedTeamInfoCellConfigurable {
    func configure(with data: TeamInfoTableViewCellData ) {
        switch data.type {
        case .mainTeamInfo(let data):
            teamNameLabel.text = data.teamNameLabelText
            winsLabel.text = data.winsLabelText
            lossesLabel.text = data.lossesLabelText
            ratingLabel.text = data.ratingLabelText
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
