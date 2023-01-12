//
//  ViewController.swift
//  JMSports
//
//  Created by Jobson Mateus on 09/01/23.
//

import UIKit
import UILayer

// TODO: Improve
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller: UIViewController = SportsViewController()
        let navigation: UINavigationController = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: false)
    }
}
