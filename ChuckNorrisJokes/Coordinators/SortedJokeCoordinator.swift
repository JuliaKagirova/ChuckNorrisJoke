//
//  ListJokeCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

class SortedJokeCoordinator: ListJokeBaseCoordinator {

    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let listVC = ListScreen()
        listVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: listVC)
        return rootViewController
    }
    
    func showListJokeScreen() {
        
    }
    
}
