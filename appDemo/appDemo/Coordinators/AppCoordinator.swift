//
//  AppCoordinator.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import Foundation
import UIKit

enum AppChildCoordinator {
    case first
    case second
    case third
    case choords
}

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController {get set}
}

protocol Coordinator: AnyObject {
    /**
     Entry point starting the coordinator
     */
    func start()
}

class AppCoordinator: TabBarCoordinator {
    private let window: UIWindow

    private var childCoordinators = [AppChildCoordinator: Coordinator]()
    var tabBarController: UITabBarController


    init(window: UIWindow) {
        self.window = window
        tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = UIColor.white
        self.window.rootViewController = tabBarController
    }


    func start() {
        var viewControllers =  [UIViewController]()

        if let elseVC = ViewControllerFactory.createViewController(ElseViewController.self, initCompleted: {vc in
            vc.tabBarItem = UITabBarItem(title: "Else One", image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle"))
        }) {
            viewControllers.append(elseVC)
        }

        if let choords = ViewControllerFactory.createViewController(ChoordsViewController.self, initCompleted: { [unowned self] choords in
            choords.tabBarItem = UITabBarItem(title: "Choords", image: UIImage(systemName: "music.note"), selectedImage: UIImage(systemName: "music.note"))
            choords.setViewModel(ChoordsViewModel(networkService: NetWorkService(), dataService: DataService()))
            choords.coordinator = self

        }) {

            viewControllers.append(choords)
        }

        if let elseVC = ViewControllerFactory.createViewController(ElseViewController.self, initCompleted: {vc in  vc.tabBarItem = UITabBarItem(title: "Else Two", image: UIImage(systemName: "square"), selectedImage: UIImage(systemName: "square")) }) {
            viewControllers.append(elseVC)
        }
        self.tabBarController.viewControllers = viewControllers
    }

    func showNetworkAlert() {
        let alertController = UIAlertController(title: "Network Error",
                                                message: "Please check your connection",
                                                preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)

        self.tabBarController.present(alertController, animated: true, completion: nil)
    }

}

