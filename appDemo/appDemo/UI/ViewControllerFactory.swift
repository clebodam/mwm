//
//  ViewControllerFactory.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//

import Foundation
import UIKit

class ViewControllerFactory {

    static func createViewController<ViewController: StoryboardLodable>(_ controllerType: ViewController.Type, initCompleted: ((ViewController) -> Void)?  = nil) -> ViewController? {
            let storyboard = UIStoryboard(name: controllerType.storyboardName, bundle: nil)
            let name = "\(controllerType)"
            let viewController = storyboard.instantiateViewController(withIdentifier: name) as! ViewController
            initCompleted?(viewController)
            return viewController

    }
}

