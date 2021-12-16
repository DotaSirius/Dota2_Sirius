import UIKit

final class PlayerMatchCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMatchCell"

    // MARK: - Properties

    private lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 30)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

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
        contentView.addSubview(name)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension PlayerMatchCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerMatch(let data):
            name.text = String(data.matchId)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
