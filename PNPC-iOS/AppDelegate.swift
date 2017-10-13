//
//  AppDelegate.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 11/10/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    // Estimote Application ID
    let estimoteAppID = "pnpc-hiking-dzz"
    
    // Estimote Token
    let estimoteToken = "960e0687ed90bfb248b4bc9c0ed268f5"
    
    // Estimote Monitoring Manager.
    var monitoringManager: ESTMonitoringV2Manager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Keyboard Manager
        IQKeyboardManager.sharedManager().enable = true
        
        // View Starter
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: self.window!)
        appCoordinator.start()
        
        // Estimote SDK
        ESTConfig.setupAppID(estimoteAppID, andAppToken: estimoteToken)
        
        
        self.monitoringManager = ESTMonitoringV2Manager(
            desiredMeanTriggerDistance: 1.0, delegate: self)
        // add this below:
        self.monitoringManager.startMonitoring(forIdentifiers: [
            "48c582894196ab5a855700a0d356e902"])
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            print("notifications allowed? = \(granted)")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    internal func showNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(
            identifier: "BeaconNotification", content: content, trigger: nil)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
}
