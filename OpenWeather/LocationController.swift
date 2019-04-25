//
//  LocationController.swift
//  OpenWeather
//
//  Created by Valerii on 15.04.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationResponse = (_ result: String?, _ error: Error?)
    -> Void

class LocationController: NSObject {
    
    static let shared = LocationController()
    var isUpdatingLocation = false
    let locationManager: CLLocationManager = CLLocationManager()
    var locetionCompletion: ((String?,Error?) -> Void)?
    
    func getLocation(completion: @escaping (LocationResponse)) {
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if authorizationStatus == .denied || authorizationStatus == .restricted {
           self.locetionCompletion = completion
        }
        if isUpdatingLocation == true {
            stopLocationManager()
        } else {
            startLocationManager()
        }
        self.locetionCompletion = completion
    }
    
    func stopLocationManager() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        isUpdatingLocation = false
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
}

extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         self.locetionCompletion!(nil,error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        stopLocationManager()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            let placemark = placemarks![0]
            let locationCity = placemark.subAdministrativeArea
            let cityNameForWeaherRequest = locationCity
            self.locetionCompletion!(cityNameForWeaherRequest ?? "Error",nil)
        })
    }
    
}
