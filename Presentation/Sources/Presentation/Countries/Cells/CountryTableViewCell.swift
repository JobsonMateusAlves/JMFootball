//
//  CountryTableViewCell.swift
//  
//
//  Created by Jobson Mateus on 14/03/23.
//

import UIKit
import Core
import Domain

class CountryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let flagImageView: UIImageView = {
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
    
    func bind(country: Country) {
        nameLabel.text = country.name
        flagImageView.cleanImage()
        if let code = country.code, let url = URL(string: "https://flagsapi.com/\(code)/flat/64.png") {
            flagImageView.setImage(with: url)
        }
    }
}

// MARK: Layout
extension CountryTableViewCell {
    func setupLayout() {
        setupLogoImageViewLayout()
        setupNameLabelLayout()
        backgroundColor = .clear
        accessoryType = .disclosureIndicator
    }
    
    func setupLogoImageViewLayout() {
        addSubview(flagImageView)
        
        let constraints: [NSLayoutConstraint] = [
            flagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            flagImageView.heightAnchor.constraint(equalToConstant: 30),
            flagImageView.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNameLabelLayout() {
        addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
