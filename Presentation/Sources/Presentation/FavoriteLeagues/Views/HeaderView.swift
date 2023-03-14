//
//  HeaderView.swift
//  
//
//  Created by Jobson Mateus on 13/03/23.
//

import UIKit

class HeaderView: UIView {
    
    let label: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Favorites"
        return label
    }()
    
    let separatorView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#222222")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupLayout()
    }

    func bind(title: String) {
        label.text = title
    }
}

extension HeaderView {
    func setupLayout() {
        setupLabelLayout()
        setupSeparatorLayout()
    }
    
    func setupLabelLayout() {
        addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSeparatorLayout() {
        addSubview(separatorView)
        
        let constraints: [NSLayoutConstraint] = [
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
