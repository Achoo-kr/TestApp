//
//  KakaoMapVCWrapper.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/19.
//

import Foundation
import SwiftUI
import UIKit

struct KakaoMapVCWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return KakaoMapVC()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}

class KakaoMapVC: UIViewController {
    
    /*
     #import <DaumMap/MTMapView.h>
     - (void)viewDidLoad {
         [super viewDidLoad];
         _mapView = [[MTMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
         _mapView.delegate = self;
         _mapView.baseMapType = MTMapTypeHybrid;
         [self.view addSubview:_mapView];

     }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MTMapView(frame: self.view.frame)
        mapView.baseMapType = .standard
        mapView.showCurrentLocationMarker = true
        
        self.view.addSubview(mapView)
    }
}

//final class Coordinator: NSObject, ObservableObject, MTMapViewDelegate, CLLocationManagerDelegate {
//    static let shared = Coordinator()
//    
//    let view = MTMapView(frame: .zero)
//    var locationManager: CLLocationManager?
//    var mapView: MTMapView?
//    
//    @Published var coord: (Double, Double) = (0.0, 0.0)
//    // @Published var userLocation: (Double, Double) = (0.0, 0.0)
//    @Published var userLocation: MTMapPointGeo?
//    
//    override init() {
//        super.init()
//        view.delegate = self
//        view.baseMapType = .standard
//        // Start checking location services
//        checkIfLocationServicesIsEnabled()
//
//        //지도 중심점, 줌 레벨 설정
//        view.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: userLocation?.latitude ?? 0.0, longitude: userLocation?.longitude ?? 0.0)), zoomLevel: 2, animated: true)
//        // 현재 위치 트래킹
//        view.showCurrentLocationMarker = true
//        view.currentLocationTrackingMode = .onWithHeading
//    }
//    
//    func getKakaoMapView() -> MTMapView {
//        view
//    }
//    
//    func checkIfLocationServicesIsEnabled() {
//         DispatchQueue.global().async {
//             if CLLocationManager.locationServicesEnabled() {
//                 DispatchQueue.main.async {
//                     self.locationManager = CLLocationManager()
//                     self.locationManager!.delegate = self
//                     self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
//                     self.checkLocationAuthorization()
//                 }
//             } else {
//                 print("Show an alert letting them know this is off and to go turn i on.")
//             }
//         }
//     }
//    
//    func checkLocationAuthorization() {
//        guard let locationManager = locationManager else { return }
//
//        switch locationManager.authorizationStatus {
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            print("Your location is restricted likely due to parental controls.")
//        case .denied:
//            print("You have denied this app location permission. Go into settings to change it.")
//        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.startUpdatingLocation()
//        @unknown default:
//            break
//        }
//    }
//    
//    // CLLocationManagerDelegate method to handle authorization changes
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
//
//    // CLLocationManagerDelegate method to handle location updates
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            userLocation = MTMapPointGeo(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            updateMapView(location: userLocation)
//        }
//    }
//
//    // MTMapViewDelegate method to update current location marker
//    internal func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
//        // Handle updates to current location marker if needed
//    }
//
//    func updateMapView(location: MTMapPointGeo?) {
//        if let mapView = mapView, let location = location {
//            mapView.setMapCenter(MTMapPoint(geoCoord: location), zoomLevel: 15, animated: true)
//            mapView.removeAllPOIItems()
//            let marker = MTMapPOIItem()
//            marker.markerType = .redPin
//            marker.mapPoint = MTMapPoint(geoCoord: location)
//            mapView.addPOIItems([marker])
//        }
//    }
//    
////    func fetchUserLocation() {
////        if let locationManager = locationManager {
////            let lat = locationManager.location?.coordinate.latitude
////            let lng = locationManager.location?.coordinate.longitude
////
////
////
////        }
////    }
////
////    // Custom: 현 위치 트래킹 함수
////    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
////        let currentLocation = userLocation
////        if let latitude = currentLocation?.latitude, let longitude = currentLocation?.longitude{
////            print("MTMapView updateCurrentLocation (\(latitude),\(longitude)) accuracy (\(accuracy))")
////        }
////        mapView.showCurrentLocationMarker = true
//////        mapView.updateCurrentLocationMarker(nil)
////
////    }
//}
//
//
