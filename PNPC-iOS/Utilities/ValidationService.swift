//
//  ValidationService.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

public final class ValidationService {
    public static func isValid(nickname: String) -> Bool {
        return nickname.characters.count >= 8
    }
}
