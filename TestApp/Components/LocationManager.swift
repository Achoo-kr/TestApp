//
//  LocationManager.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var locationUpdateHandler: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: - 사용자 위치정보 동의 분기 처리
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            
            case .restricted:
                print("Your location is restricted likely due to parental controls.")
            
            case .denied:
                print("You have denied this app location permission. Go into setting to change it.")
            
            case .authorizedAlways, .authorizedWhenInUse:
                print("Success")
                currentLocation = CLLocation(latitude: (locationManager.location?.coordinate.latitude ?? 321286),
                                             longitude: locationManager.location?.coordinate.longitude ?? 533707)
                print("LocationManager-currentLocation: \(String(describing: currentLocation))")
            
        @unknown default:
            break
        }
    }
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on.")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocation = location
            locationUpdateHandler?(location)
        }
    }
}
