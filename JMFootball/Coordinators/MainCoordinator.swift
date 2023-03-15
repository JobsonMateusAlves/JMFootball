//
//  MainCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 12/03/23.
//

import UIKit
import Core
import Presentation

class MainCoordinator: Coordinator {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if UserDefaults.alreadySetFavorites() {
            startLeaguesFlow()
            return
        }
        startWelcomeFlow()
    }
    
    private func startLeaguesFlow() {
        let viewController = LeaguesViewController(viewModel: LeaguesFactory.createViewModel())
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func startWelcomeFlow() {
        let coordinator = WelcomeCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

