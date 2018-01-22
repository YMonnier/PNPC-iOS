//
//  PNPCService.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import Moya

enum PNPCService {
    case login(nickname: String, password: String)
    case passage(userID: Int, beaconID: String)
}

extension PNPCService: TargetType {
    var baseURL: URL { return URL(string: "https://cloud-lsis-3.lsis.univ-tln.fr/PNPC/api")! }
    var path: String {
        switch self {
        case .login: return "/users/login"
        case .passage(let userID, let beaconID): return "/users/\(userID)/passages/\(beaconID)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .login, .passage: return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let nickname, let password): return [
            "nickname": nickname,
            "mdp": password]
        case .passage: return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .login, .passage:
            // Send parameters as JSON in request body
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        case .login, .passage: // Always send parameters as JSON in request body
            return .request
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json",
                "Authorization": Settings.authToken]
    }
}
