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
    var newNavigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        newNavigationController = UINavigationController(
            rootViewController: FavoriteLeaguesViewController(
                coordinator: self,
                viewModel: FavoriteLeaguesFactory.createViewModel()
            )
        )
        newNavigationController?.modalPresentationStyle = .overFullScreen
        if let navigation = newNavigationController {
            navigationController.present(navigation, animated: true)
        }
    }
    
    func startAddFavoriteLeagues() {
        guard let navigation = newNavigationController else { return }
        let coordinator = CountriesCoordinator(navigationController: navigation)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
