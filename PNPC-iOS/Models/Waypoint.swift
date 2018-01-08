//
//  Waypoint.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 10/11/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import ObjectMapper

struct Waypoint: Mappable {
    var id: Int
    var latitude: Double
    var longitude: Double
    
    // MARK: JSON
    init?(map: Map) {
        id = -1
        latitude = 0.0
        longitude = 0.0
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
    }
}
