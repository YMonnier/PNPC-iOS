//
//  MapViewModel.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 10/11/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import RxCocoa
import RxSwift
import Moya
import Moya_ObjectMapper

public final class MapViewModel {
    /// Annoatations from PNPC API
    var annotations: Observable<[Waypoint]>
    
    // Network Provider
    let provider = RxMoyaProvider<PNPCService>()
    
    private let disposeBag = DisposeBag()
    
    public init() {
        annotations = provider.request(.joke)
            .mapArray(Waypoint.self)
    }
}
