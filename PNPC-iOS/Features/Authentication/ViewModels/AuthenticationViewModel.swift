//
//  AuthenticationViewModel.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import RxCocoa
import RxSwift


public final class AuthenticationModelView {
    /// Sending new elements trough this property
    /// starts checking email validation.
    var nicknameText = Variable<String>("")

    /// Sending new elements trough this property
    /// starts Login HTTP request.
    var loginTaps = Variable<Void>()

    /// Is login button enabled
    let signupEnabled: Observable<Bool>
    
    public init() {
        signupEnabled = nicknameText.asObservable()
            .distinctUntilChanged()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .map { s in
                return ValidationService.isValid(nickname: s)
            }.shareReplay(1)
    }
}
