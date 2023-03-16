//
//  LeaguesViewController.swift
//  Presentation
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import Core
import Domain

// MARK: - Leagues Actions Protocol
public protocol Leagues {
    
}

// TODO: Improve Layout
// MARK: - LeaguesViewController
public class LeaguesViewController: JMViewController {

    // MARK: Properties
    private let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .primaryBackgroundColor
        return tableView
    }()

    private let coordinator: (Coordinator & Leagues)
    private let viewModel: LeaguesViewModel

    // MARK: Inits
    public init(coordinator: (Coordinator & Leagues), viewModel: LeaguesViewModel) {
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
        title = "Leagues"

        setupLayout()
        setupTableView()
        loadData()
    }

    func loadData() {
        viewModel.fetchLeagues { [weak self] in
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
        viewModel.numberOfLeagues
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(league: viewModel.leagueAt(index: indexPath.row))
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

// MARK: - Layout
extension LeaguesViewController {

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
