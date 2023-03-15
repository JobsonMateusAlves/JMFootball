//
//  CountryTableViewCell.swift
//  
//
//  Created by Jobson Mateus on 14/03/23.
//

import UIKit
import Domain

class CountryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let flagImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageLoader: ImageLoader = ImageLoader()

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
        flagImageView.image = nil
        if let flag = country.flag, let url = URL(string: flag) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.flagImageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader.cancel()
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
            flagImageView.heightAnchor.constraint(equalToConstant: 32),
            flagImageView.widthAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        layoutIfNeeded()
        flagImageView.layer.cornerRadius = flagImageView.frame.width / 2
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
