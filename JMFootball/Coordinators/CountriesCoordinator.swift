//
//  CountriesCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 14/03/23.
//

import UIKit
import Core
import Domain
import Presentation

class CountriesCoordinator: Coordinator, Countries {
    
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = CountriesViewController(coordinator: self, viewModel: CountriesFactory.createViewModel())
        navigationController.pushViewController(controller, animated: true)
    }
    
    func startLeaguesFlow(with country: Domain.Country) {
        let coordinator = LeaguesCoordinator(navigationController: navigationController, country: country)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
