//
//  OverAll.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/8/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
extension Optional {
    
    var not: Bool {
        switch self {
        case .none:
            return false
        case .some(let wrapped):
            if let value = wrapped as? Bool {
                return !value
            } else {
                return false
            }
        }
    }
    
    func then(_ hendler: (Wrapped) -> Void) {
        switch self {
        case .some(let wrapped):
            return hendler(wrapped)
        case .none:
            break
        }
    }
}

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardId) as? T else {
            fatalError("Cast error to \(T.self)")
        }
        return viewController
    }
}
extension UIViewController {
    class var storyboardId: String {
        return String(describing: self)
    }
}

