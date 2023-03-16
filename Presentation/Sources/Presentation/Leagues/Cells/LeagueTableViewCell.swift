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
    
    let logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let favoritedImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
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
    
    func bind(league: League) {
        nameLabel.text = "\(league.name)"
        if let url = URL(string: league.logo) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.logoImageView.image = image
            }
        }
        favoritedImageView.image = league.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader.cancel()
    }
}

// MARK: Layout
extension LeagueTableViewCell {
    func setupLayout() {
        setupLogoImageViewLayout()
        setupNameLabelLayout()
        setupFavoritedImageViewLayout()
        backgroundColor = .clear
    }
    
    func setupLogoImageViewLayout() {
        addSubview(logoImageView)
        
        let constraints: [NSLayoutConstraint] = [
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            logoImageView.heightAnchor.constraint(equalToConstant: 32),
            logoImageView.widthAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNameLabelLayout() {
        addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupFavoritedImageViewLayout() {
        addSubview(favoritedImageView)
        
        let constraints: [NSLayoutConstraint] = [
            favoritedImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            favoritedImageView.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 16),
            favoritedImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            favoritedImageView.heightAnchor.constraint(equalToConstant: 32),
            favoritedImageView.widthAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
