//
//  RootViewCoordinator.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit

public protocol RootViewControllerProvider: class {
    /// The coordinators 'rootViewController'.
    /// It helps to think of this as the view
    /// controller that can be used to dismiss
    /// the coordinator from the view hierarchy.
    var rootViewController: UIViewController { get }
}

/// A Coordinator type that provides a root UIViewController
public typealias RootViewCoordinator = Coordinator & RootViewControllerProvider

