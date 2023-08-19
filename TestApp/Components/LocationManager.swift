//
//  LocationManager.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

//import CoreLocation
//
//class LocationManager: NSObject, CLLocationManagerDelegate {
//    var currentLocation: CLLocation?
//    private var locationManager = CLLocationManager()
//    
//    var locationUpdateHandler: ((CLLocation) -> Void)?
//    
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            self.currentLocation = location
//            locationUpdateHandler?(location)
//        }
//    }
//}
