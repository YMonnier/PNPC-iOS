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

public protocol AuthenticationControllerDelegate: class {
    func AuthenticationLoginIn()
}

public final class AuthenticationViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Variable
    private let disposeBag = DisposeBag()
    
    // Keep the View and Model updated.
    private let viewModel: AuthenticationModelView
    
    /// Coordinator Delegate
    public weak var delegate: AuthenticationControllerDelegate?
    
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
        print(#function)
        
        nicknameField.rx.text.orEmpty
            .bind(to: viewModel.nicknameText)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginTap)
            .disposed(by: disposeBag)
        
        viewModel.signupEnabled
            .subscribe(onNext: { [weak self] valid  in
                print(valid)
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        
        /*viewModel.response?
            .subscribe(onNext: { [weak self] json in
                print(json)
            }).disposed(by: disposeBag)*/
        
        
        viewModel.response?.subscribe { event in
            print("Event: \(event)")
            switch event {
            
            case .next(let response):
                print("Response... \(response)")
                delegate?.AuthenticationLoginIn()
                /*if let jsonOpt = try? response.mapJSON() {
                    print("JSON... \(jsonOpt)")
                }*/
                break
            // do something with the data
            case .error(let error):
                print(error)
                break
            case .completed:
                print("completed...")
                break
                // handle the error
            }
        }.disposed(by: disposeBag)
    }
    
}
