//
//  HeaderView.swift
//  
//
//  Created by Jobson Mateus on 13/03/23.
//

import UIKit

protocol HeaderViewButtonDelegate {
    func onHeaderButtonClick()
}

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
        view.backgroundColor = .separatorColor
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    var buttonDelegate: HeaderViewButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        setupLayout()
        setupButton()
    }
    
    func setupButton() {
        button.addTarget(self, action: #selector(HeaderView.didHeaderButtonClicked), for: .touchUpInside)
    }

    func bind(title: String) {
        label.text = title
    }
    
    func set(buttonTitle: String) {
        button.setTitle(buttonTitle, for: .normal)
    }
    
    @objc func didHeaderButtonClicked() {
        buttonDelegate?.onHeaderButtonClick()
    }
}

extension HeaderView {
    func setupLayout() {
        setupButtonLayout()
        setupLabelLayout()
        setupSeparatorLayout()
    }
    
    func setupLabelLayout() {
        addSubview(label)
        
        let constraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupButtonLayout() {
        addSubview(button)
        
        let constraints: [NSLayoutConstraint] = [
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 60)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSeparatorLayout() {
        addSubview(separatorView)
        
        let constraints: [NSLayoutConstraint] = [
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
