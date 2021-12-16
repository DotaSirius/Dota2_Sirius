import UIKit

final class AdditionalMatchInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AdditionalMatchInfoTableViewCell"
    var matchID = String()
    let inset: CGFloat = 16
    let buttonWidth: CGFloat = 200
    let buttonHeight: CGFloat = 32

    private lazy var regionStackView: UIStackView = {
        let regionStackView = UIStackView()
        createStackView(stackView: regionStackView, axis: .vertical, spacing: 8)
        regionStackView.translatesAutoresizingMaskIntoConstraints = false
        return regionStackView
    }()

    private lazy var skillStackView: UIStackView = {
        let skillStackView = UIStackView()
        createStackView(stackView: skillStackView, axis: .vertical, spacing: 8)
        skillStackView.translatesAutoresizingMaskIntoConstraints = false
        return skillStackView
    }()

    private lazy var matchIdCopyButton: CopyIdButton = {
        let matchIdCopyButton = CopyIdButton()
        matchIdCopyButton.setTitle("Copy match ID", for: .normal)
        matchIdCopyButton.layer.cornerRadius = 15
        matchIdCopyButton.backgroundColor = ColorPalette.alternativeBackground
        matchIdCopyButton.setTitleColor(ColorPalette.text, for: .normal)
        matchIdCopyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        matchIdCopyButton.addTarget(self, action: #selector(copyMatchIdButtonPressed), for: .touchUpInside)
        matchIdCopyButton.translatesAutoresizingMaskIntoConstraints = false
        return matchIdCopyButton
    }()

    private lazy var regionNameLabel: UILabel = {
        let regionNameLabel = UILabel()
        regionNameLabel.text = "REGION"
        regionNameLabel.textColor = ColorPalette.subtitle
        regionNameLabel.font = UIFont.systemFont(ofSize: 15)
        return regionNameLabel
    }()

    private lazy var regionLabel: UILabel = {
        let regionLabel = UILabel()
        regionLabel.textColor = ColorPalette.mainText
        regionLabel.font = UIFont.systemFont(ofSize: 15)
        regionLabel.numberOfLines = 3
        regionLabel.textAlignment = .center
        return regionLabel
    }()

    private lazy var skillNameLabel: UILabel = {
        let skillNameLabel = UILabel()
        skillNameLabel.text = "SKILL"
        skillNameLabel.textColor = ColorPalette.subtitle
        skillNameLabel.font = UIFont.systemFont(ofSize: 15)
        return skillNameLabel
    }()

    private lazy var skillLabel: UILabel = {
        let skillLabel = UILabel()
        skillLabel.textColor = ColorPalette.mainText
        skillLabel.font = UIFont.systemFont(ofSize: 15)
        skillLabel.numberOfLines = 3
        skillLabel.textAlignment = .center
        return skillLabel
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
        [matchIdCopyButton,
         regionStackView,
         skillStackView].forEach {
            contentView.addSubview($0)
        }
        [regionNameLabel,
         regionLabel].forEach {
            regionStackView.addArrangedSubview($0)
        }
        [skillNameLabel,
         skillLabel].forEach {
            skillStackView.addArrangedSubview($0)
        }
    }

    @objc
    private func copyMatchIdButtonPressed() {
        UIPasteboard.general.string = matchID
        matchIdCopyButton.setTitle("Copied!", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.matchIdCopyButton.setTitle("Copy match ID", for: .normal)
        }
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            matchIdCopyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            matchIdCopyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            matchIdCopyButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            matchIdCopyButton.heightAnchor.constraint(equalToConstant: buttonHeight),

            regionStackView.topAnchor.constraint(equalTo: matchIdCopyButton.bottomAnchor, constant: inset),
            regionStackView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -inset),
            regionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            regionStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

            skillStackView.topAnchor.constraint(equalTo: matchIdCopyButton.bottomAnchor, constant: inset),
            skillStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            skillStackView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: inset),
            skillStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
}

extension AdditionalMatchInfoTableViewCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .additionalMatchInfo(let data):
            matchID = data.matchIdLabelText
            regionLabel.text = data.regionLabelText
            skillLabel.text = data.skillLabelText
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
