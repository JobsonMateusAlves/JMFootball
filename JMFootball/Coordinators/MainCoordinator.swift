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
            startHomeFlow()
            return
        }
        startWelcomeFlow()
    }
    
    private func startWelcomeFlow() {
        let coordinator = WelcomeCoordinator(navigationController: navigationController)
        coordinator.finish = { [weak self] in
            self?.startFavoriteLeaguesFlow()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func startFavoriteLeaguesFlow() {
        let coordinator = FavoriteLeguesCoordinator(navigationController: navigationController)
        coordinator.finish = { [weak self] in
            self?.startHomeFlow()
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func startHomeFlow() {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

