//
//  MainCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 12/03/23.
//

import UIKit
import Presentation

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = LeaguesViewController(viewModel: LeaguesFactory.createViewModel())
        navigationController.pushViewController(viewController, animated: false)
    }
}
