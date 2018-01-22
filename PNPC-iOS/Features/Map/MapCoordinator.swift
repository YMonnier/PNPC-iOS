//
//  MapCoordinator.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 10/11/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit

protocol MapCoordinatorDelegate: class {
    
    /// The user tapped the cancel button
    func logout(mapCoordinator: MapCoordinator)
}


public final class MapCoordinator: RootViewCoordinator {
    /// The coordinators 'rootViewController'.
    /// It helps to think of this as the view
    /// controller that can be used to dismiss
    /// the coordinator from the view hierarchy.
    public var rootViewController: UIViewController {
        return self.navigationController
    }
    
    weak var delegate: MapCoordinatorDelegate?
    
    /// The array containing any child Coordinators
    public var childCoordinators: [Coordinator] = []
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = false
        
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barTintColor = UIColor(red: 3/255, green: 122/255, blue: 98/255, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        return navigationController
    }()
    
    public init() {}
    
    
    /// Start the coordination.
    public func start() {
        showMapViewController()
    }
    
    /// Create View Model and inject it to the view controller.
    private func showMapViewController() {
        let vm = MapViewModel()
        let viewController = MapViewController(viewModel: vm)
        viewController.delegate = self
        navigationController.viewControllers = [viewController]
    }
}

extension MapCoordinator: MapViewControllerDelegate {
    public func logout() {
        self.delegate?.logout(mapCoordinator: self)
    }
}
