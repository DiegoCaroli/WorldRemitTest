//
//  Storyboarded.swift
//  WorldRemitTest
//
//  Created by Diego Caroli on 26/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

protocol Storyboarded: class {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let className = String(describing: self)
        let bundle = Bundle(for: AppDelegate.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
