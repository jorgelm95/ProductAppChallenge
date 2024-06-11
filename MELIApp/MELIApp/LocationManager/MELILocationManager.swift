//
//  MELILocationManager.swift
//  MELIApp
//
//  Created by Jorge Menco on 10/06/24.
//

import CoreLocation

class MELILocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = MELILocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestLocationAuthorization()
    }
    public func requestLocationAuthorization() {
        self.locationManager.delegate = self
        let currentStatus =  self.locationManager.authorizationStatus
        if currentStatus == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        } else if currentStatus == .authorizedWhenInUse {
            self.locationManager.requestAlwaysAuthorization()
        }
     }
}
