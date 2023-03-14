//
//  AddItemCollectionViewCell.swift
//  
//
//  Created by Jobson Mateus on 13/03/23.
//

import UIKit

class AddItemCollectionViewCell: UICollectionViewCell {
    
    let plusImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-plus")
        imageView.tintColor = .white
        return imageView
    }()
    
    let backgroundCircleView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#414141")
        return view
    }()
    
    let externalBackgroundCircleView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#848484")
        label.font = .systemFont(ofSize: 12)
        label.text = "Add"
        return label
    }()
    
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
    }
}

// MARK: Layout
extension AddItemCollectionViewCell {
    func setupLayout() {
        setupExternalBackgroundCircleViewLayout()
        setupBackgroundCirvleViewLayout()
        setupPlusImageViewLayout()
        setupLabelLayout()
        setupBorders()
    }
    
    func setupExternalBackgroundCircleViewLayout() {
        addSubview(externalBackgroundCircleView)
        
        layoutIfNeeded()
        
        let constraints: [NSLayoutConstraint] = [
            externalBackgroundCircleView.topAnchor.constraint(equalTo: topAnchor),
            externalBackgroundCircleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            externalBackgroundCircleView.heightAnchor.constraint(equalToConstant: frame.width),
            externalBackgroundCircleView.widthAnchor.constraint(equalToConstant: frame.width)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBackgroundCirvleViewLayout() {
        externalBackgroundCircleView.addSubview(backgroundCircleView)
        
        let constraints: [NSLayoutConstraint] = [
            backgroundCircleView.topAnchor.constraint(equalTo: externalBackgroundCircleView.topAnchor, constant: 20),
            backgroundCircleView.leadingAnchor.constraint(equalTo: externalBackgroundCircleView.leadingAnchor, constant: 20),
            backgroundCircleView.trailingAnchor.constraint(equalTo: externalBackgroundCircleView.trailingAnchor, constant: -20),
            backgroundCircleView.bottomAnchor.constraint(equalTo: externalBackgroundCircleView.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupPlusImageViewLayout() {
        backgroundCircleView.addSubview(plusImageView)
        
        let constraints: [NSLayoutConstraint] = [
            plusImageView.topAnchor.constraint(equalTo: backgroundCircleView.topAnchor, constant: 12),
            plusImageView.leadingAnchor.constraint(equalTo: backgroundCircleView.leadingAnchor, constant: 12),
            plusImageView.trailingAnchor.constraint(equalTo: backgroundCircleView.trailingAnchor, constant: -12),
            plusImageView.bottomAnchor.constraint(equalTo: backgroundCircleView.bottomAnchor, constant: -12)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupLabelLayout() {
        addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: externalBackgroundCircleView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBorders() {
        layoutIfNeeded()
        
        externalBackgroundCircleView.layer.cornerRadius = externalBackgroundCircleView.frame.width / 2
        externalBackgroundCircleView.layer.borderWidth = 2
        externalBackgroundCircleView.layer.borderColor = UIColor(hex: "#333333").withAlphaComponent(0.6).cgColor
        
        backgroundCircleView.layer.cornerRadius = backgroundCircleView.frame.width / 2
    }
}
