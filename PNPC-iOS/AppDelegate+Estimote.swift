//
//  AppDelegate+Estimote.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 13/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

extension AppDelegate: ESTMonitoringV2ManagerDelegate {
    func monitoringManagerDidStart(_ manager: ESTMonitoringV2Manager) {
        print("monitoringManagerDidStart")
    }
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didFailWithError error: Error) {
        print("monitoringManager didFailWithError: \(error.localizedDescription)")
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didEnterDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didEnter proximity of beacon \(identifier)")
        
        showNotification(title: "Hello world", body: "Looks like you're near a beacon.")
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didExitDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didExit proximity of beacon \(identifier)")
        
        showNotification(title: "Goodbye world", body: "You left the proximity of a beacon.")
    }
    
    func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didDetermineInitialState state: ESTMonitoringState,
                           forBeaconWithIdentifier identifier: String) {
        // state codes: 0 = unknown, 1 = inside, 2 = outside
        print("didDetermineInitialState '\(state)' for beacon \(identifier)")
    }
}
