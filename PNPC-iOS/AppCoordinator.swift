//
//  AppCoordinator.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit

public final class AppCoordinator: RootViewCoordinator {
    /// The coordinators 'rootViewController'.
    /// It helps to think of this as the view
    /// controller that can be used to dismiss
    /// the coordinator from the view hierarchy.
    public var rootViewController: UIViewController {
        return self.navigationController
    }
    
    /// Window to manage
    let window: UIWindow
    
    /// The array containing any child Coordinators
    public var childCoordinators: [Coordinator] = []
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    public init(window: UIWindow) {
        self.window = window
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    
    /// Start the coordination.
    public func start() {
        showLoginViewController()
    }
    
    /// Create View Model and inject it to the view controller.
    private func showLoginViewController() {
        let viewModel = AuthenticationModelView()
        
        let viewController = AuthenticationViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }
}

extension AppCoordinator: AuthenticationControllerDelegate {
    public func authenticationLoginIn() {
        
    }
}
