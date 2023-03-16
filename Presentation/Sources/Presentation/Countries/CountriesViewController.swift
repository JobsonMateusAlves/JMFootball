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
    func startLeaguesFlow(with country: Country)
}

// MARK: - CountriesViewController
public class CountriesViewController: JMViewController {
    
    // MARK: Properties
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .primaryBackgroundColor
        return tableView
    }()
    
    private let coordinator: (Coordinator & Countries)
    private let viewModel: CountriesViewModel
    
    // MARK: Inits
    public init(coordinator: (Coordinator & Countries), viewModel: CountriesViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    func loadData() {
        viewModel.fetchCountries { [weak self] in
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
        return viewModel.numberOfCountries
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(country: viewModel.countryAt(index: indexPath.row))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.startLeaguesFlow(with: viewModel.countryAt(index: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Layout
extension CountriesViewController {

    override func setupLayout() {
        super.setupLayout()
        setupTableViewLayout()
    }

    func setupTableViewLayout() {
        view.addSubview(tableView)

        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: appHeaderView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
