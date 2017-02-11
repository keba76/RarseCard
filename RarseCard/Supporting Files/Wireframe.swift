//
//  Wireframe.swift
//  TableRx
//
//  Created by Ievgen Keba on 1/29/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import RxSwift
import UIKit

protocol Wireframe {
    func promptFor<Action: CustomStringConvertible>(_ message: String, controller: UIViewController, cancelAction: Action, actions: [Action]) -> Observable<Action>
}

class DefaultWireframe: Wireframe {
    
    static let sharedInstance = DefaultWireframe()
    private static func rootViewController() -> UIViewController {
        // cheating, I know
        return UIApplication.shared.keyWindow!.rootViewController!
    }
    func promptFor<Action : CustomStringConvertible>(_ message: String, controller: UIViewController, cancelAction: Action, actions: [Action]) -> Observable<Action> {
        return Observable.create { observer in
            let alertView = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
            alertView.addAction(UIAlertAction(title: cancelAction.description, style: .cancel) { _ in
                observer.on(.next(cancelAction))
            })
            for action in actions {
                alertView.addAction(UIAlertAction(title: action.description, style: .default) { _ in
                    observer.on(.next(action))
                })
            }
            controller.present(alertView, animated: true, completion: nil)
            return Disposables.create {
                alertView.dismiss(animated:false, completion: nil)
            }
        }
    }
}
