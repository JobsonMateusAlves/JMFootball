//
//  LeagueTableViewCell.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import Core
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
    
    let logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        if let url = URL(string: league.logo) {
            logoImageView.setImage(with: url)
        }
    }
}

// MARK: Layout
extension LeagueTableViewCell {
    func setupLayout() {
        setupLogoImageViewLayout()
        setupNameLabelLayout()
        setupCountryLabelLayout()
    }
    
    func setupLogoImageViewLayout() {
        addSubview(logoImageView)
        
        let constraints: [NSLayoutConstraint] = [
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 16),
            logoImageView.widthAnchor.constraint(equalToConstant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNameLabelLayout() {
        addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupCountryLabelLayout() {
        addSubview(countryLabel)
        
        let constraints: [NSLayoutConstraint] = [
            countryLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            countryLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
