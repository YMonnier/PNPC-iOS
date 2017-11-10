//
//  MapViewController.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 10/11/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

public protocol MapViewControllerDelegate: class {
    func logout()
}

public final class MapViewController: UIViewController {
    // MARK: @IBOutlet
    
    // MARK: Variable
    private let disposeBag = DisposeBag()
    
    // Keep the View and Model updated.
    private let viewModel: MapViewModel
    
    /// Coordinator Delegate
    public weak var delegate: MapViewControllerDelegate?
    
    // MARK: Setup
    override public func viewDidLoad() {
        super.viewDidLoad()
        //addBindsTo(viewModel: viewModel)
        addLogoutButton()
    }
    
    init(viewModel vm: MapViewModel) {
        viewModel = vm
        super.init(nibName: "MapViewController", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        viewModel = MapViewModel()
        super.init(coder: aDecoder)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Logout",
                                        style: .done,
                                        target: self,
                                        action: #selector(logoutAction))
        if let _ = navigationController {
            navigationItem.leftBarButtonItem = logoutButton
        }
    }
    
    @objc private func logoutAction() {
        delegate?.logout()
    }
}
