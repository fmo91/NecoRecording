//
//  NavigationHelper.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

/// Class used just to make transitions between view controllers.
/// The transition that is made by this class is a fade in/out transition
/// between two VCs.
internal enum NavigationHelper {
    /// Makes a transition between two view controllers
    /// The view controller that is set by this method is designed
    /// as the root view controller in the UIWindow object.
    ///
    /// - Parameter viewController: The destination view controller for the transition
    /// - Parameter animated. Whether the transition is animated or not.
    static internal func setRoot(viewController: UIViewController, animated: Bool) {
        guard let applicationDelegate: UIApplicationDelegate = UIApplication.shared.delegate else { return }
        guard let aWindow: UIWindow? = applicationDelegate.window, let window: UIWindow = aWindow else { return }
        
        if (animated == false || window.rootViewController == nil) {
            window.rootViewController = viewController
        } else if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            window.rootViewController = viewController
            
            snapshot.frame = window.frame
            window.addSubview(snapshot)
            
            UIView.animate(withDuration: 0.35, animations: { () -> Void in
                snapshot.alpha = 0
            }, completion: { (_) -> Void in
                snapshot.removeFromSuperview()
            })
        }
    }
}
