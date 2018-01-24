//
//  MapViewController.swift
//  PNPC-iOS
//
//  Created by Ysée MONNIER on 10/11/2017.
//  Copyright © 2017 ymonnier. All rights reserved.
//

import UIKit

import MapKit
import CoreLocation

import RxCocoa
import RxSwift

import UserNotifications
import NotificationBannerSwift

public protocol MapViewControllerDelegate: class {
    func logout()
}

public final class MapViewController: UIViewController {
    // MARK: @IBOutlet
    @IBOutlet internal weak var mapView: MKMapView!
    
    // MARK: Variable
    private let disposeBag = DisposeBag()
    
    // Keep the View and Model updated.
    private let viewModel: MapViewModel
    
    /// Coordinator Delegate.
    public weak var delegate: MapViewControllerDelegate?
    
    /// Location Manager.
    private var locationManager: CLLocationManager
    internal var currentLocation: CLLocation?
    
    // Estimote Monitoring Manager.
    var monitoringManager: ESTMonitoringV2Manager!
    
    // MARK: Setup
    override public func viewDidLoad() {
        super.viewDidLoad()
        //addBindsTo(viewModel: viewModel)
        addLogoutButton()
        
        mapView.showsUserLocation = true
        
        // Location Manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }

        // Estimotes
        monitoringManager = ESTMonitoringV2Manager(
            desiredMeanTriggerDistance: 1.0, delegate: self)

        monitoringManager.startMonitoring(forIdentifiers: [
            "48c582894196ab5a855700a0d356e902"])
    }
    
    init(viewModel vm: MapViewModel) {
        viewModel = vm
        locationManager = CLLocationManager()
        super.init(nibName: "MapViewController", bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        viewModel = MapViewModel()
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Logout",
                                        style: .done,
                                        target: self,
                                        action: #selector(logoutAction))
        if let _ = navigationController {
            navigationItem.leftBarButtonItem = logoutButton
        }
    }
    
    @objc private func logoutAction() {
        delegate?.logout()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }
}


extension MapViewController: ESTMonitoringV2ManagerDelegate {
    public func monitoringManagerDidStart(_ manager: ESTMonitoringV2Manager) {
        print("monitoringManagerDidStart")
        showNotification(title: "PNPC", body: "À la recherche des Beacons!")
    }
    
    public func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didFailWithError error: Error) {
        print("monitoringManager didFailWithError: \(error.localizedDescription)")
    }
    
    public func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didEnterDesiredRangeOfBeaconWithIdentifier identifier: String) {
        
        print("didEnter proximity of beacon \(identifier)")
        showNotification(title: "PNPC", body: "On dirait que vous êtes près d'une balise.")
    }
    
    public func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didExitDesiredRangeOfBeaconWithIdentifier identifier: String) {
        print("didExit proximity of beacon \(identifier)")
        
        showNotification(title: "PNPC", body: "On dirait que vous êtes près d'une balise.")
        showNotification(title: "Goodbye world", body: "Vous avez quitté la balise de localisation.")
    }
    
    public func monitoringManager(_ manager: ESTMonitoringV2Manager,
                           didDetermineInitialState state: ESTMonitoringState,
                           forBeaconWithIdentifier identifier: String) {
        // state codes: 0 = unknown, 1 = inside, 2 = outside
        print("didDetermineInitialState '\(state)' for beacon \(identifier)")
    }
    
    private func showNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        let request = UNNotificationRequest(
            identifier: "BeaconNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
        NotificationBanner(title: title, subtitle: body, style: .success).show()
    }
}

