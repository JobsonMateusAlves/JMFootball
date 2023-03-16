//
//  LeagueCollectionViewCell.swift
//  
//
//  Created by Jobson Mateus on 13/03/23.
//

import UIKit
import Domain

class LeagueCollectionViewCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let backgroundCircleView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let externalBackgroundCircleView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryTextColor
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let imageLoader: ImageLoader = ImageLoader()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        isUserInteractionEnabled = true
    }
    
    func bind(league: League) {
        nameLabel.text = league.name
        logoImageView.image = nil
        if let url = URL(string: league.logo) {
            imageLoader.loadImage(with: url) { [weak self] image in
                self?.logoImageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader.cancel()
    }
}

// MARK: Layout
extension LeagueCollectionViewCell {
    func setupLayout() {
        setupExternalBackgroundCircleViewLayout()
        setupBackgroundCirvleViewLayout()
        setupLogoImageViewLayout()
        setupNameLabelLayout()
        setupBorders()
    }
    
    func setupExternalBackgroundCircleViewLayout() {
        addSubview(externalBackgroundCircleView)
        
        layoutIfNeeded()
        
        let constraints: [NSLayoutConstraint] = [
            externalBackgroundCircleView.topAnchor.constraint(equalTo: topAnchor),
            externalBackgroundCircleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            externalBackgroundCircleView.heightAnchor.constraint(equalToConstant: frame.width - 16),
            externalBackgroundCircleView.widthAnchor.constraint(equalToConstant: frame.width - 16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBackgroundCirvleViewLayout() {
        externalBackgroundCircleView.addSubview(backgroundCircleView)
        
        let constraints: [NSLayoutConstraint] = [
            backgroundCircleView.topAnchor.constraint(equalTo: externalBackgroundCircleView.topAnchor, constant: 16),
            backgroundCircleView.leadingAnchor.constraint(equalTo: externalBackgroundCircleView.leadingAnchor, constant: 16),
            backgroundCircleView.trailingAnchor.constraint(equalTo: externalBackgroundCircleView.trailingAnchor, constant: -16),
            backgroundCircleView.bottomAnchor.constraint(equalTo: externalBackgroundCircleView.bottomAnchor, constant: -16)
        ]
        
        backgroundCircleView.backgroundColor = .terciaryBackgroundColor
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupLogoImageViewLayout() {
        backgroundCircleView.addSubview(logoImageView)
        
        let constraints: [NSLayoutConstraint] = [
            logoImageView.topAnchor.constraint(equalTo: backgroundCircleView.topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: backgroundCircleView.leadingAnchor, constant: 8),
            logoImageView.trailingAnchor.constraint(equalTo: backgroundCircleView.trailingAnchor, constant: -8),
            logoImageView.bottomAnchor.constraint(equalTo: backgroundCircleView.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNameLabelLayout() {
        addSubview(nameLabel)
        
        let constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: externalBackgroundCircleView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBorders() {
        layoutIfNeeded()
        
        externalBackgroundCircleView.layer.cornerRadius = externalBackgroundCircleView.frame.width / 2
        externalBackgroundCircleView.layer.borderWidth = 2
        externalBackgroundCircleView.layer.borderColor = UIColor.primaryBorderColor.withAlphaComponent(0.6).cgColor
        
        backgroundCircleView.layer.cornerRadius = backgroundCircleView.frame.width / 2
    }
}

