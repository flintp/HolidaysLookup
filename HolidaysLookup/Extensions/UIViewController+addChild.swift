//
//  UIViewController+addChild.swift
//  HolidaysLookup
//
//  Created by Julian Flint Pearce on 14/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.removeFromParent()
        child.view.removeFromSuperview()
    }
}
