//
//  WardsMapTableViewCell.swift
//  DotaStats
//
//  Created by Борисов Матвей Евгеньевич on 17.12.2021.
//

import UIKit

final class WardsMapTableViewCell: UITableViewCell {
    static let reuseIdentifier = "WardsMapTableViewCell"

    private let map = UIImageView(image: UIImage(named: "map"))
    private let slider = UISlider()

    private var events = [Int: [MatchEvent]]()
    private var matchTime: Int {
        events.count
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupActions()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        selectionStyle = .none
        contentView.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: contentView.topAnchor),
            map.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            map.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            map.heightAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        contentView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: map.bottomAnchor, constant: 20),
            slider.leftAnchor.constraint(equalTo: map.leftAnchor, constant: 10),
            slider.rightAnchor.constraint(equalTo: map.rightAnchor, constant: -10),
            slider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    private func setupActions() {
        slider.addTarget(self, action: #selector(sliderAction(sender:)), for: .valueChanged)
    }

    @objc private func sliderAction(sender: UISlider) {
        let currentTime = convertToTime(from: sender.value)
        guard let currentEvents = events[currentTime] else {
            return
        }
        clearMap()
        currentEvents.forEach { event in
            guard let coordinates = event.coordinates,
                  let isRadiant = event.involvedPlayers.first?.isRadiant
            else {
                return
            }
            switch event.eventType {
            case .observer:
                drawWard(coordinates: coordinates, isObserver: true, isRadiant: isRadiant)
            case .sentry:
                drawWard(coordinates: coordinates, isObserver: false, isRadiant: isRadiant)
            default:
                break
            }
        }
    }

    private func convertToTime(from value: Float) -> Int {
        Int(value * Float(matchTime))
    }

    private func drawWard(coordinates: (x: Int, y: Int), isObserver: Bool, isRadiant: Bool) {
        let wardView = createWardView(isObserver: isObserver, isRadiant: isRadiant)
        map.addSubview(wardView)
        wardView.center.x = convertToMapCoordsX(coordinates.x)
        wardView.center.y = convertToMapCoordsY(coordinates.y)
    }

    private func convertToMapCoordsX(_ value: Int) -> CGFloat {
        CGFloat(value - 64) / 128 * map.frame.width
    }

    private func convertToMapCoordsY(_ value: Int) -> CGFloat {
        CGFloat(192 - value) / 128 * map.frame.width
    }

    private func createWardView(isObserver: Bool, isRadiant: Bool) -> UIView {
        let size: CGFloat = isObserver ? 60 : 30
        let wardView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        wardView.layer.cornerRadius = size / 2
        wardView.layer.borderWidth = 1
        wardView.backgroundColor = isRadiant ? .green : .red
        wardView.layer.borderColor = wardView.backgroundColor?.cgColor
        wardView.backgroundColor = wardView.backgroundColor?.withAlphaComponent(0.25)
        return wardView
    }

    private func clearMap() {
        map.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }

}

// MARK: - AdditionalMatchInfoTableViewCell

extension WardsMapTableViewCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .wardsMapInfo(let newEvents):
            events = newEvents
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
