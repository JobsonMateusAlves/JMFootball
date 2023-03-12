//
//  Coordinator.swift
//  JMFootball
//
//  Created by Jobson Mateus on 12/03/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
