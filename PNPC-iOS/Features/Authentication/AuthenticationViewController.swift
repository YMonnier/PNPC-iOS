//
//  AuthenticationViewController.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

public final class AuthenticationViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Variable
    private let disposeBag = DisposeBag()
    
    // Keep the View and Model updated.
    private let viewModel: AuthenticationModelView
    
    // MARK: Setup
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.isEnabled = false
        addBindsTo(viewModel: viewModel)
    }
    
    init(viewModel vm: AuthenticationModelView) {
        viewModel = vm
        super.init(nibName: "AuthenticationViewController", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        viewModel = AuthenticationModelView()
        super.init(coder: aDecoder)
    }
    
    
    private func addBindsTo(viewModel: AuthenticationModelView) {
        nicknameField.rx.text.orEmpty.asObservable()
            .bind(to: viewModel.nicknameText)
            .disposed(by: disposeBag)
        
        viewModel.signupEnabled
            .subscribe(onNext: { [weak self] valid  in
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)

        
    }

}
