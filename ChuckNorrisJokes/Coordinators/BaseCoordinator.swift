//
//  BaseCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

typealias Action = (() -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
// MARK: - Tabbar Protocol

protocol LoadJokeBaseCoordinator: Coordinator {
    func showLoadJokeScreen()
}

protocol ListJokeBaseCoordinator: Coordinator {
    func showListJokeScreen()
}

protocol SortedJokeBaseCoordinator: Coordinator {
    func showSortedJokeScreen()
}

protocol MainBaseCoordinator: Coordinator {
    var loadJokeCoordinator: LoadJokeBaseCoordinator { get }
    var listJokeCoordinator: ListJokeBaseCoordinator { get }
    var sortedJokeCoordinator: SortedJokeBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}


