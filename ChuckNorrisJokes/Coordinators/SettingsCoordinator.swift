//
//  SettingsCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 30.08.2024.
//

import UIKit

class SettingsCoordinator: SettingsBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: settingsVC)
        return rootViewController
    }
    
    func showSettings() {
        
    }
    
}
