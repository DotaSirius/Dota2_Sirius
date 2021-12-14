import UIKit

protocol ListTournamentsCellDelegate: AnyObject {
    func toggleSection(header: ListTournamentsCell, section: Int)
}

final class ListTournamentsCell: UITableViewHeaderFooterView {
    static let reuseIdentifier = "ListTournamentsCell"
    weak var delegate: ListTournamentsCellDelegate?
    var section: Int?

    func setup(withTitle title: String, section: Int, delegate: ListTournamentsCellDelegate) {
        self.delegate = delegate
        self.section = section
        self.title.text = title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addView()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        delegate?.toggleSection(header: self, section: (self.section)!)
    }

    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    lazy var arrowLabel: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "chevron.right"))
        view.tintColor = ColorPalette.accent
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setCollapsed(_ collapsed: Bool) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = collapsed ? 0.0 : .pi / 2
        animation.duration = 0.2
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        arrowLabel.layer.add(animation, forKey: nil)
    }

    func addView() {
        contentView.addSubview(title)
        contentView.addSubview(arrowLabel)
        contentView.backgroundColor = ColorPalette.separator

        NSLayoutConstraint.activate([
            arrowLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
