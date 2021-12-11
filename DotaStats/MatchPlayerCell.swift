import UIKit

class MatchPlayerCell: UITableViewCell {
    private let colorPalette = ColorPalette()

    static let reuseIdentifier = "MatchPlayerCell"

    private let playerNameLabel = UILabel()

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
        contentView.backgroundColor = colorPalette.mainBackground
        [playerNameLabel].forEach { contentView.addSubview($0) }

        playerNameLabel.textColor = colorPalette.mainText
        playerNameLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
    }

    func setUpConstraints() {
        [playerNameLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        playerNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
        playerNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        playerNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension MatchPlayerCell: DetailedMatchInfoCellConfigurable {
    //    func configure(with data: MatchTableViewCellType) {
    //        matchIdLabel.text = "74753461439" //данные придут из сети
    //        regionLabel.text = "Stockholm" //данные придут из сети
    //        skillLabel.text = "Normal Skill" //данные придут из сети
    //    }
    func configure(with data: String) {
        playerNameLabel.text = "Player" // данные придут из сети
    }
}
