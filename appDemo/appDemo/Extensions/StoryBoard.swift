//
//  StoryBoard.swift
//  appDemo
//
//  Created by Damien on 29/11/2021.
//
import Foundation
import UIKit

protocol StoryboardLodable: AnyObject {
     static var storyboardName: String { get }
     static var tabName: String { get }
}

protocol ChoordsLodable: StoryboardLodable {
}

protocol ElseLodable: StoryboardLodable {
}


extension ChoordsLodable where Self: UIViewController {
     static var storyboardName: String {
        return "ChoordsViewController"
    }

     static var tabName: String {
        return "Choords"
    }
}

extension ElseLodable where Self: UIViewController {
     static var storyboardName: String {
        return "ElseViewController"
    }

     static var tabName: String {
        return "Else"
    }
}




