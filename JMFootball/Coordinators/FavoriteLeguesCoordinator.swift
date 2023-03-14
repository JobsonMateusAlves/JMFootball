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
        let navigation = UINavigationController(
            rootViewController: FavoriteLeaguesViewController(
                coordinator: self,
                viewModel: FavoriteLeaguesFactory.createViewModel()
            )
        )
        navigation.modalPresentationStyle = .overFullScreen
        navigationController.present(navigation, animated: true)
    }
}
