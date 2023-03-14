//
//  CountriesViewController.swift
//  
//
//  Created by Jobson Mateus on 14/03/23.
//

import UIKit
import Domain
import Core

public protocol Countries {
    
}

public class CountriesViewController: UIViewController {
    
    // MARK: Properties
    let coordinator: (Coordinator & Countries)
    
    // MARK: Inits
    public init(coordinator: (Coordinator & Countries)) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
