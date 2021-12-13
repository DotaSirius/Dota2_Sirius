import UIKit

class AdditionalMatchInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AdditionalMatchInfoTableViewCell"
    var matchID = String()
    
    private let regionStackView = UIStackView()
    private let skillStackView = UIStackView()

    private let matchIdCopyButton = CopyButton()
    private let regionNameLabel = UILabel()
    private let regionLabel = UILabel()
    private let skillNameLabel = UILabel()
    private let skillLabel = UILabel()
    
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
        contentView.backgroundColor = ColorPalette.mainBackground
        [matchIdCopyButton, regionStackView, skillStackView].forEach { contentView.addSubview($0) }
        
        matchIdCopyButton.setTitle("Copy match ID", for: .normal)
        matchIdCopyButton.layer.cornerRadius = 15
        matchIdCopyButton.backgroundColor = ColorPalette.alternatеBackground
        matchIdCopyButton.setTitleColor(ColorPalette.text, for: .normal)
        matchIdCopyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        matchIdCopyButton.addTarget(self, action: #selector(copyMatchIdButtonPressed), for: .touchUpInside)

        regionNameLabel.text = "REGION"
        regionNameLabel.textColor = ColorPalette.subtitle
        regionNameLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        skillNameLabel.text = "SKILL"
        skillNameLabel.textColor = ColorPalette.subtitle
        skillNameLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        regionLabel.textColor = ColorPalette.mainText
        regionLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        regionLabel.numberOfLines = 0
        regionLabel.textAlignment = .center
        
        skillLabel.textColor = ColorPalette.mainText
        skillLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        skillLabel.numberOfLines = 0
        skillLabel.textAlignment = .center
        
        createStackView(stackView: regionStackView, axis: .vertical, spacing: 8)
        [regionNameLabel, regionLabel].forEach { regionStackView.addArrangedSubview($0) }

        createStackView(stackView: skillStackView, axis: .vertical, spacing: 8)
        [skillNameLabel, skillLabel].forEach { skillStackView.addArrangedSubview($0) }
    }
                                    
    @objc
    private func copyMatchIdButtonPressed() {
        print("Button tapped")
        UIPasteboard.general.string = matchID
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }
    
    func setUpConstraints() {
        [matchIdCopyButton, regionStackView, skillStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        matchIdCopyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        matchIdCopyButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        matchIdCopyButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        matchIdCopyButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        regionStackView.topAnchor.constraint(equalTo: matchIdCopyButton.bottomAnchor, constant: 16).isActive = true
        regionStackView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -16).isActive = true
        regionStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        regionStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
        
        skillStackView.topAnchor.constraint(equalTo: matchIdCopyButton.bottomAnchor, constant: 16).isActive = true
        skillStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        skillStackView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 16).isActive = true
        skillStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor).isActive = true
    }
}

extension AdditionalMatchInfoTableViewCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .additionalMatchInfo(let data):
            matchID = data.matchIdLabelText
            regionLabel.text = data.regionLabelText
            skillLabel.text = data.skillLabelText
        default: break
        }
    }
}
