//
//  FavoriteLeguesCoordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 13/03/23.
//

import UIKit
import Core
import Presentation

class FavoriteLeguesCoordinator: Coordinator, FavoriteLeagues {
    
    var finish: (() -> Void)?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = FavoriteLeaguesViewController(coordinator: self, viewModel: FavoriteLeaguesFactory.createViewModel())
        UIView.transition(with: navigationController.view, duration: 0.8, options: [.transitionFlipFromRight]) { [weak self] in
            self?.navigationController.viewControllers.removeAll()
            self?.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
    func startAddFavoriteLeaguesFlow() {
        let coordinator = CountriesCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func finishFavoriteLeaguesFlow() {
        finish?()
    }
}
