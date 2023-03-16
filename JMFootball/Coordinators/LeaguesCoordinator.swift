//
//  LeaguesCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 15/03/23.
//

import UIKit
import Core
import Presentation
import Domain

class LeaguesCoordinator: Coordinator, Leagues {
    
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var country: Domain.Country?
    
    init(navigationController: UINavigationController, country: Country?) {
        self.navigationController = navigationController
        self.country = country
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = LeaguesViewController(coordinator: self, viewModel: LeaguesFactory.createViewModel(with: country))
        navigationController.pushViewController(controller, animated: true)
    }
}
