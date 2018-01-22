//
//  AuthenticationViewModel.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import RxCocoa
import RxSwift
import Moya

public final class AuthenticationModelView {
    /// Sending new elements trough this property
    /// starts checking email validation.
    var nicknameText = Variable<String>("")
    
    /// Sending new elements trough this property
    /// starts checking email validation.
    var passwordText = Variable<String>("")

    /// Sending new elements trough this property
    /// starts Login HTTP request.
    var loginTap = Variable<Void>()

    /// Is login button enabled
    let signupEnabled: Observable<Bool>
    
    /// Response HTTP
    var response: Observable<Response>?
    
    // Network Provider
    let provider = RxMoyaProvider<PNPCService>()
    
    public init() {
        let nickname = nicknameText.asObservable()
        let password = passwordText.asObservable()
        
        let validateNickname = nickname
            .distinctUntilChanged()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map { s in
                return ValidationService.isValid(nickname: s)
            }.shareReplay(1)
        
        let validatePassword = password
            .distinctUntilChanged()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map { s in
                return ValidationService.isValid(nickname: s)
            }.shareReplay(1)
        
        signupEnabled = Observable.combineLatest(validateNickname, validatePassword) { $0 && $1 }
        
        let parameters = Observable.combineLatest(nickname, password)
        response = loginTap.asObservable()
            .withLatestFrom(parameters)
            .flatMap { (nn, pp) in
                //self.provider.request(.login(nickname: nn))
                self.provider.request(.login(nickname: nn,
                                             password: pp))
            }.debug("loginTap.asObservable...").shareReplay(1)
        
        /*provider.request(.login(nickname: "zedzed")).subscribe { event in
            switch event {
            case .next(let response):
                
                break
            // do something with the data
            case .error(let error):
                break
                // handle the error
            }
        }*/
    }
}
