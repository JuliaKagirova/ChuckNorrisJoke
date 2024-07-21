//
//  MapCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 16.07.2024.
//

import UIKit

class MapCoordinator: MapBaseCoordinator {
  
    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let mapVC = MapScreen()
        mapVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: mapVC)
        return rootViewController
    }
    
    func showMapScreen() {
        
    }
    
   
}
