//
//  HomeViewController.swift
//  
//
//  Created by Jobson Mateus on 16/03/23.
//

import UIKit
import Domain
import Core

// MARK: - Welcome Actions Protocol
public protocol Home {
    
}

// MARK: - WelcomeViewController
public class HomeViewController: JMViewController {

    private let coordinator: (Coordinator & Home)
    
    // MARK: Inits
    public init(coordinator: (Coordinator & Home)) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

    }
}
