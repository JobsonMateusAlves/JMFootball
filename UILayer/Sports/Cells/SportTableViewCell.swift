//
//  SportTableViewCell.swift
//  JMSportsTests
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import DomainLayer

class SportTableViewCell: UITableViewCell {
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func bind(sport: Sport) {
        self.nameLabel.text = sport.name
        self.descriptionLabel.text = sport.description
    }
}

// MARK: Layout
extension SportTableViewCell {
    func setupLayout() {
        setupNameLabelLayout()
        setupDescriptionLabelLayout()
    }
    
    func setupNameLabelLayout() {
        self.addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupDescriptionLabelLayout() {
        self.addSubview(descriptionLabel)
        
        let constraints: [NSLayoutConstraint] = [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
