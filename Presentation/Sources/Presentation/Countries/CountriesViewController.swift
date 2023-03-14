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
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(hex: "#151515")
        return tableView
    }()
    
    let coordinator: (Coordinator & Countries)
    
    // MARK: Inits
    public init(coordinator: (Coordinator & Countries)) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

// MARK: - Layout
extension CountriesViewController {

    func setupLayout() {
        setupTableViewLayout()
        view.backgroundColor = UIColor(hex: "#163A70")
    }

    func setupTableViewLayout() {
        view.addSubview(tableView)

        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
