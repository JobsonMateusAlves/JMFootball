//
//  SportsViewController.swift
//  JMSportsTests
//
//  Created by Jobson Mateus on 12/01/23.
//

import UIKit
import DataLayer
import DomainLayer

public class SportsViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var data: [Sport] = [
        Sport(id: "1", name: "Futebol", description: "Futebol é um esporte onde 2 times de 11 jogadores se enfrentam chutando uma bola e tentando fazer gols."),
        Sport(id: "2", name: "Basquete", description: "Basquete é um esporte legal."),
        Sport(id: "3", name: "Volei", description: "Volei é um esporte muito legal.")
    ]
    
    // TODO: Improve
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.setupTableView()
        self.title = "Sports"
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SportTableViewCell.self, forCellReuseIdentifier: "SportTableViewCell")
    }
}

// MARK: UITableViewDelegate And UITableViewDataSource
extension SportsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SportTableViewCell", for: indexPath) as? SportTableViewCell else {
            return UITableViewCell()
        }
        cell.bind(sport: self.data[indexPath.row])
        return cell
    }
}

// MARK: Layout
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

