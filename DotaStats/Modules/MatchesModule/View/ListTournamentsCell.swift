import UIKit

class ListTournamentsCell: UITableViewCell {
    static let reuseIdentifier = "ListTournamentsCell"
    
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
    
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -305)
        ])
    }
}
