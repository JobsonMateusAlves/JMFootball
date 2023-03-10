//
//  LeagueTableViewCell.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import Domain

class LeagueTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let countryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func bind(league: League) {
        nameLabel.text = "\(league.id) - \(league.name)"
        countryLabel.text = league.country
    }
}

// MARK: Layout
extension LeagueTableViewCell {
    func setupLayout() {
        setupNameLabelLayout()
        setupDescriptionLabelLayout()
    }
    
    func setupNameLabelLayout() {
        addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupDescriptionLabelLayout() {
        addSubview(countryLabel)
        
        let constraints: [NSLayoutConstraint] = [
            countryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            countryLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
