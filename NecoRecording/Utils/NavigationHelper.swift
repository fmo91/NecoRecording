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
    static internal func setRoot(from originViewController: UIViewController, to viewController: UIViewController, animated: Bool) {
        guard let window: UIWindow = (originViewController.scene?.delegate as? SceneDelegate)?.window else { return }
        
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

extension UIResponder {
    @objc var scene: UIScene? {
        return nil
    }
}

extension UIScene {
    @objc override var scene: UIScene? {
        return self
    }
}

extension UIView {
    @objc override var scene: UIScene? {
        if let window = self.window {
            return window.windowScene
        } else {
            return self.next?.scene
        }
    }
}

extension UIViewController {
    @objc override var scene: UIScene? {
        // Try walking the responder chain
        var res = self.next?.scene
        if (res == nil) {
            // That didn't work. Try asking my parent view controller
            res = self.parent?.scene
        }
        if (res == nil) {
            // That didn't work. Try asking my presenting view controller
            res = self.presentingViewController?.scene
        }

        return res
    }
}
