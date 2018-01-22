//
//  User.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 22/01/2018.
//  Copyright © 2018 ymonnier. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    var id: Int
    var nickname: String
    var authToken: String
    var email: String
    
    // MARK: JSON
    init?(map: Map) {
        id = -1
        email = ""
        nickname = ""
        authToken = ""
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        nickname <- map["nickname"]
        authToken <- map["authToken"]
    }
}
