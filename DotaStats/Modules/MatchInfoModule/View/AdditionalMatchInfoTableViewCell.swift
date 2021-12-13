//
//  AddMatchInfo.swift
//  DotaStats
//
//  Created by Костина Вероника  on 10.12.2021.
//
import UIKit

class AdditionalMatchInfoTableViewCell: UITableViewCell {
    private let colorPalette = ColorPalette()

    static let reuseIdentifier = "AdditionalMatchInfoTableViewCell"
    
    private let idStackView = UIStackView()
    private let regionStackView = UIStackView()
    private let skillStackView = UIStackView()
    private let idRegionSkillStackView = UIStackView()
    
    private let matchIdNameLabel = UILabel()
    private let matchIdLabel = UILabel()
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
        [idRegionSkillStackView].forEach { contentView.addSubview($0) }
        // TODO: - Изменить шрифт
        matchIdNameLabel.text = "ID"
        matchIdNameLabel.textColor = ColorPalette.subtitle
        matchIdNameLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        regionNameLabel.text = "REGION"
        regionNameLabel.textColor = ColorPalette.subtitle
        regionNameLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        skillNameLabel.text = "SKILL"
        skillNameLabel.textColor = ColorPalette.subtitle
        skillNameLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        matchIdLabel.textColor = ColorPalette.mainText
        matchIdLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        regionLabel.textColor = ColorPalette.mainText
        regionLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        skillLabel.textColor = ColorPalette.mainText
        skillLabel.font = UIFont.systemFont(ofSize: 15) // изменить шрифт
        
        createStackView(stackView: idStackView, axis: .vertical, spacing: 8)
        [matchIdNameLabel, matchIdLabel].forEach { idStackView.addArrangedSubview($0) }
        
        createStackView(stackView: regionStackView, axis: .vertical, spacing: 8)
        [regionNameLabel, regionLabel].forEach { regionStackView.addArrangedSubview($0) }
        
        createStackView(stackView: skillStackView, axis: .vertical, spacing: 9)
        [skillNameLabel, skillLabel].forEach { skillStackView.addArrangedSubview($0) }
        
        createStackView(stackView: idRegionSkillStackView, axis: .horizontal, spacing: 24)
        [idStackView, regionStackView, skillStackView].forEach { idRegionSkillStackView.addArrangedSubview($0) }
    }
    
    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = spacing
    }
    
    func setUpConstraints() {
        [idRegionSkillStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        idRegionSkillStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32).isActive = true
        idRegionSkillStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        idRegionSkillStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension AdditionalMatchInfoTableViewCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .additionalMatchInfo(let data):
            matchIdLabel.text = data.matchIdLabelText
            regionLabel.text = data.regionLabelText
            skillLabel.text = data.skillLabelText
        default: break
        }
    }
}
