import UIKit

protocol ListTournamentsCellDelegate: AnyObject {
    func toggleSection(header: ListTournamentsCell, section: Int)
}
class ListTournamentsCell: UITableViewHeaderFooterView {
    
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
        addView()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        let cell = gesterRecognizer.view as! ListTournamentsCell
        delegate?.toggleSection(header: self, section: cell.section!)
    }
    
    lazy var title: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        control.textAlignment = .center
        control.textColor = ColorPalette.mainText
        control.translatesAutoresizingMaskIntoConstraints = false
        control.numberOfLines = 3
        control.textAlignment = .center
        return control
        
    }()
 
    func addView() {
        contentView.addSubview(title)
        contentView.backgroundColor = ColorPalette.separator

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ])
    }
}
