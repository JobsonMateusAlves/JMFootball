//
//  AppHeaderView.swift
//  
//
//  Created by Jobson Mateus on 15/03/23.
//

import UIKit

protocol AppHeaderViewBackButtonDelegate {
    func onClick()
    func isHidden() -> Bool
}

class AppHeaderView: UIView {
    
    let label: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Noteworthy", size: 32)
        label.text = "Favorites"
        return label
    }()
    
    let backButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    let separatorView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separatorColor
        return view
    }()
    
    var buttonDelegate: AppHeaderViewBackButtonDelegate? {
        didSet {
            setupBackButton()
        }
    }
    
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
        setupBackButton()
        setupStackView()
    }
    
    func setupBackButton() {
        backButton.isHidden = buttonDelegate?.isHidden() ?? false
        backButton.addTarget(self, action: #selector(AppHeaderView.didBackButtonClicked), for: .touchUpInside)
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(label)
    }

    func bind(title: String) {
        label.text = title
    }
    
    @objc func didBackButtonClicked() {
        buttonDelegate?.onClick()
    }
}

extension AppHeaderView {
    func setupLayout() {
        setupStackViewLayout()
        setupBackButtonLayout()
        setupSeparatorLayout()
    }
    
    func setupStackViewLayout() {
        addSubview(stackView)
        
        let constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupBackButtonLayout() {
        addSubview(backButton)

        let constraints: [NSLayoutConstraint] = [
            backButton.widthAnchor.constraint(equalToConstant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 16)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupSeparatorLayout() {
        addSubview(separatorView)
        
        let constraints: [NSLayoutConstraint] = [
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
