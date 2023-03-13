//
//  LeaguesViewController.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import Domain

// TODO: Improve Layout
// MARK: - LeaguesViewController
public class LeaguesViewController: UIViewController {

    // MARK: Properties
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let viewModel: LeaguesViewModel

    // MARK: Inits
    public init(viewModel: LeaguesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"

        setupLayout()
        setupTableView()
        loadData()
    }

    func loadData() {
        viewModel.fetchLeagues { [weak self] in
            if let error = self?.viewModel.error {
                // TODO: Remove and improve error handling
                let alert: UIAlertController = UIAlertController(title: "Atenção", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self?.present(alert, animated: true)
                return
            }
            self?.tableView.reloadData()
        }
    }

    // MARK: Setup
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeagueTableViewCell.self, forCellReuseIdentifier: "LeagueTableViewCell")
    }
}

// MARK: - UITableViewDelegate And UITableViewDataSource
extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLeagues
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(league: viewModel.leagueAt(index: indexPath.row))
        return cell
    }
}

// MARK: - Layout
extension LeaguesViewController {

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
