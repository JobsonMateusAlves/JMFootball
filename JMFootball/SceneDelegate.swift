//
//  SceneDelegate.swift
//  JMFootball
//
//  Created by Jobson Mateus on 09/03/23.
//

import UIKit
import Domain
import Data
import Presentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController()
            coordinator = MainCoordinator(navigationController: navigationController)
            coordinator?.start()
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
            print("STARTED")
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

