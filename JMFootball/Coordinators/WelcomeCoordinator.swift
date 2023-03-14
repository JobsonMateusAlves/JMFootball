//
//  WelcomeCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 12/03/23.
//

import UIKit
import Core
import Presentation

class WelcomeCoordinator: Coordinator, Welcome {
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = WelcomeViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func startFavoritesFlow() {
        let coordinator = FavoriteLeguesCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
