//
//  SportsViewController.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import Foundation
import Domain

// MARK: - SportsViewController
public class SportsViewController: UIViewController {

    // MARK: Properties
    let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel: SportsViewModel!

    // MARK: Inits
    public init(viewModel: SportsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sports"

        setupLayout()
        setupTableView()
        loadData()
    }

    func loadData() {
        viewModel.fetchSports { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: Setup
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SportTableViewCell.self, forCellReuseIdentifier: "SportTableViewCell")
    }
}

// MARK: - UITableViewDelegate And UITableViewDataSource
extension SportsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSports
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SportTableViewCell", for: indexPath) as? SportTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(sport: viewModel.sportAt(index: indexPath.row))
        return cell
    }
}

// MARK: - Layout
extension SportsViewController {

    func setupLayout() {
        setupTableViewLayout()
    }

    func setupTableViewLayout() {
        view.addSubview(tableView)

        let constraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
