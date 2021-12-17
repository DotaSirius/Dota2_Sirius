import UIKit

final class TeamButtonsInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TeamButtonsInfoTableViewCell"
    let inset: CGFloat = 32
    let smallInset: CGFloat = 16
    var output: TeamInfoModuleViewOutput?

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Matches", "Players", "Heroes"])
        segmentedControl.tintColor = ColorPalette.accent
        segmentedControl.sizeToFit()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.foregroundColor: ColorPalette.mainText], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        return segmentedControl
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
        contentView.addSubview(segmentedControl)
    }

    @objc
    func valueChanged(_ sender: UISegmentedControl) {
        output?.pickSection(sender.selectedSegmentIndex)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -smallInset)
        ])
    }
}

extension TeamButtonsInfoTableViewCell: DetailedTeamInfoCellConfigurable {
    func configure(with data: TeamInfoTableViewCellData) {
        switch data.type {
        case .preferredDataViewModePicker:
            break
        default:
            assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
