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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let viewModel: LeaguesViewModel = LeaguesViewModel(
                useCase: LeaguesUseCaseImpl(
                    leaguesRepository: LeaguesRepositoryImpl(
                        provider: LeaguesProviderImpl()
                    )
                )
            )
            window.rootViewController = UINavigationController(rootViewController: LeaguesViewController(viewModel: viewModel))
            self.window = window
            window.makeKeyAndVisible()
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

