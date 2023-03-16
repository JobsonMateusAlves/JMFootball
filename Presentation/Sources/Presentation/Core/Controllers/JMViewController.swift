//
//  JMViewController.swift
//  
//
//  Created by Jobson Mateus on 15/03/23.
//

import UIKit

public class JMViewController: UIViewController {
    
    // MARK: Properties
    let appHeaderView: AppHeaderView = {
        let view: AppHeaderView = AppHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bind(title: "JMFootball")
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        appHeaderView.buttonDelegate = self
        
        setupLayout()
    }
}

extension JMViewController: AppHeaderViewBackButtonDelegate {
    func onClick() {
        navigationController?.popViewController(animated: true)
    }
    
    func isHidden() -> Bool {
        navigationController?.shouldHideBackButton() ?? true
    }
}

extension JMViewController {
    @objc func setupLayout() {
        setupAppHeaderViewLayout()
        view.backgroundColor = .black
    }
    
    private func setupAppHeaderViewLayout() {
        view.addSubview(appHeaderView)
        
        let constraints: [NSLayoutConstraint] = [
            appHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appHeaderView.heightAnchor.constraint(equalToConstant: 56)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
