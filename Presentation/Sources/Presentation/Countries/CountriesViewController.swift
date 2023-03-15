//
//  CountriesViewController.swift
//  
//
//  Created by Jobson Mateus on 14/03/23.
//

import UIKit
import Domain
import Core

// MARK: - Countries Actions Protocol
public protocol Countries {
    
}

// MARK: - CountriesViewController
public class CountriesViewController: UIViewController {
    
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .primaryBackgroundColor
        return tableView
    }()
    
    let coordinator: (Coordinator & Countries)
    let vieWModel: CountriesViewModel
    
    // MARK: Inits
    public init(coordinator: (Coordinator & Countries), vieWModel: CountriesViewModel) {
        self.coordinator = coordinator
        self.vieWModel = vieWModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTableView()
        loadData()
    }
    
    func loadData() {
        vieWModel.fetchCountries { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: Setup
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "CountryTableViewCell")
    }
}

// MARK: - UITableViewDelegate And UITableViewDataSource
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vieWModel.numberOfCountries
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(country: vieWModel.countryAt(index: indexPath.row))
        return cell
    }
}

// MARK: - Layout
extension CountriesViewController {

    func setupLayout() {
        setupTableViewLayout()
        view.backgroundColor = .navigationBarBackgroundColor // TODO: Create colors
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
