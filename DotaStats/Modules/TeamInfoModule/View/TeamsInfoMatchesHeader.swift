import UIKit

final class TeamsInfoMatchesHeader: UITableViewCell {
    // MARK: - Properties

    static let reuseIdentifier = "TeamsInfoMatchesHeader"

    private lazy var number: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var results: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var duration: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var enemy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup constrains

    private func setup() {
        backgroundColor = ColorPalette.mainBackground

        contentView.addSubview(number)
        contentView.addSubview(duration)
        contentView.addSubview(results)
        contentView.addSubview(enemy)

        NSLayoutConstraint.activate([
            number.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            number.centerYAnchor.constraint(equalTo: centerYAnchor),
            number.trailingAnchor.constraint(equalTo: duration.leadingAnchor, constant: -22),

            duration.trailingAnchor.constraint(equalTo: results.leadingAnchor, constant: -10),
            duration.centerYAnchor.constraint(equalTo: centerYAnchor),
            duration.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 165),

            results.trailingAnchor.constraint(equalTo: enemy.leadingAnchor, constant: -30),
            results.centerYAnchor.constraint(equalTo: centerYAnchor),
            results.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 240),

            enemy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            enemy.centerYAnchor.constraint(equalTo: centerYAnchor),
            enemy.widthAnchor.constraint(equalToConstant: 70)

        ])
    }
}

extension TeamsInfoMatchesHeader: DetailedTeamInfoCellConfigurable {
    // MARK: - Cell configuration

    func configure(with data: TeamInfoTableViewCellData) {
        number.text = "Matches"
        duration.text = "Duration"
        results.text = "Result"
        enemy.text = "Enemy"
    }
}
