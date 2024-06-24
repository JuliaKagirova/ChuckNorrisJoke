//
//  SortedJokeCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

class SortedJokeCoordinator: SortedJokeBaseCoordinator {

    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let sortedVC = SortedJokeScreen()
        sortedVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: sortedVC)
        return rootViewController
    }
    
    func showSortedJokeScreen() {
        
    }
    
}
