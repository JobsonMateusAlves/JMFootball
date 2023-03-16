//
//  HomeCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 16/03/23.
//

import UIKit
import Core
import Presentation
import Domain



class HomeCoordinator: Coordinator, Home {
    
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
        let controller = HomeViewController(coordinator: self)
        UIView.transition(with: navigationController.view, duration: 0.5, options: [.transitionCrossDissolve]) { [weak self] in
            self?.navigationController.viewControllers.removeAll()
            self?.navigationController.setViewControllers([controller], animated: true)
        }
    }
}
