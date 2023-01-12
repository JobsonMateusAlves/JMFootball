//
//  SportsViewController.swift
//  JMSportsTests
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import DataLayer
import DomainLayer

// MARK: - SportsViewController
public class SportsViewController: UIViewController {
    
    // MARK: Properties
    let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: SportsViewModel
    
    // MARK: Inits
    public init() {
        self.viewModel = SportsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(viewModel: SportsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = SportsViewModel()
        super.init(coder: coder)
    }
    
    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sports"
        
        self.setupLayout()
        self.setupTableView()
        self.setupViewModel()
        self.loadData()
    }
    
    func loadData() {
        self.viewModel.fetchSports()
    }
    
    // MARK: Setup
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SportTableViewCell.self, forCellReuseIdentifier: "SportTableViewCell")
    }
    
    func setupViewModel() {
        self.viewModel.delegate = self
    }
}

// MARK: - ViewModelDelegate
extension SportsViewController: SportsViewModelDelegate {
    func sportsViewModel(_ viewModel: SportsViewModel, didUpdateSports sports: [DomainLayer.Sport]) {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate And UITableViewDataSource
extension SportsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfSports
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SportTableViewCell", for: indexPath) as? SportTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(sport: self.viewModel.sportAt(index: indexPath.row))
        return cell
    }
}

// MARK: - Layout
extension SportsViewController {
    
    func setupLayout() {
        self.setupTableViewLayout()
    }
    
    func setupTableViewLayout() {
        self.view.addSubview(tableView)
        
        let constraints: [NSLayoutConstraint] = [
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

