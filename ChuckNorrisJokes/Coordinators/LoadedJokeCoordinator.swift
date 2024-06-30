//
//  LoadedJokeCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

class LoadedJokeCoordinator: LoadedJokeBaseCoordinator {
  
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let loadVC = LoadScreen()
        loadVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: loadVC)
        return rootViewController
    }
    
    func showLoadedJokeScreen() {

    }
}
