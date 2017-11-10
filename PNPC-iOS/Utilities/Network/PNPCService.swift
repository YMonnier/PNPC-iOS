//
//  PNPCService.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import Moya

enum PNPCService {
    case login(nickname: String)
    case joke
}

extension PNPCService: TargetType {
    var baseURL: URL { return URL(string: "https://api.icndb.com")! }
    var path: String {
        switch self {
        case .login: return "/login"
        case .joke: return "/jokes/random/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login: return .post
        case .joke: return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let nickname): return ["nickname": nickname]
        case .joke: return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login, .joke:
            // Send parameters as JSON in request body
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        case .login, .joke: // Always send parameters as JSON in request body
            return .request
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
