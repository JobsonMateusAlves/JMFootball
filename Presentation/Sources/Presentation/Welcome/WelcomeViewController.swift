//
//  File.swift
//  
//
//  Created by Jobson Mateus on 12/03/23.
//

import UIKit
import Domain
import Core

// TODO: Improve Layout
// MARK: - LeaguesViewController
public protocol Welcome {
    func startPreferencesFlow()
}

public class WelcomeViewController: UIViewController {

    // MARK: Properties
    private let backgroundImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "welcome-background")
        imageView.alpha = 0.6
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "JMFootball"
        label.font = UIFont(name: "Noteworthy", size: 32)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let startButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.backgroundColor = UIColor(hex: "#163a70")
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()

    let coordinator: (Coordinator & Welcome)
    
    // MARK: Inits
    public init(coordinator: (Coordinator & Welcome)) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"

        navigationController?.isNavigationBarHidden = true
        setup()
        setupLayout()
    }
    
    func setup() {
        startButton.addTarget(self, action: #selector(WelcomeViewController.start), for: .touchUpInside)
    }
    
    @objc func start() {
        coordinator.start()
    }
}

// MARK: - Layout
extension WelcomeViewController {

    func setupLayout() {
        view.backgroundColor = .black
        setupBackgroundImageViewLayout()
        setupTitleLabelLayout()
        setupStartButton()
    }
    
    func setupBackgroundImageViewLayout() {
        view.addSubview(backgroundImageView)
        
        let constraints: [NSLayoutConstraint] = [
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupTitleLabelLayout() {
        view.addSubview(titleLabel)
        
        let constraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 64)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupStartButton() {
        view.addSubview(startButton)
        
        let constraints: [NSLayoutConstraint] = [
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            startButton.heightAnchor.constraint(equalToConstant: 52)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
